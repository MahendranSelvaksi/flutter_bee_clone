import 'package:dio/dio.dart';
// import 'dart:io'; // Uncomment this in a real Flutter project for File operations

// A simple service class to encapsulate API calls
class ApiService {
  final Dio _dio;

  ApiService() : _dio = Dio(); // Initialize Dio instance

  /// Simulates uploading a single photo to a storage service.
  /// In a real Flutter app, 'photoFile' would be a 'dart:io.File' object.
  /// This method would typically use Dio's FormData to send the file.
  Future<String> uploadPhoto(String photoFileName) async {
    try {
      print('Uploading photo: $photoFileName...');
      // Simulate network delay and a successful upload
      await Future.delayed(const Duration(milliseconds: 500));

      // In a real app, this would be a POST request with FormData:
      /*
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(photoFile.path, filename: photoFile.path.split('/').last),
      });
      final response = await _dio.post('https://api.example.com/upload', data: formData);
      if (response.statusCode == 200 && response.data != null && response.data.containsKey('url')) {
        return response.data['url'];
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to upload photo: ${response.statusCode}',
        );
      }
      */

      // For demonstration, return a mock URL
      final mockUrl = 'https://cdn.example.com/photos/${Uri.encodeComponent(photoFileName)}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      print('Photo uploaded. URL: $mockUrl');
      return mockUrl;
    } on DioException catch (e) {
      print('Error uploading photo: $e');
      if (e.response != null) {
        print('Error data: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      print('Unexpected error uploading photo: $e');
      rethrow;
    }
  }

  /// Submits the main form data, including the uploaded photo URLs.
  Future<Map<String, dynamic>> submitFormDataWithPhotos(Map<String, dynamic> formData) async {
    try {
      print('Submitting form data with photos: $formData');
      final response = await _dio.post('https://api.example.com/submit_form', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Form submission successful. Response: ${response.data}');
        return response.data as Map<String, dynamic>;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed to submit form: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('Error submitting form: $e');
      if (e.response != null) {
        print('Error data: ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      print('Unexpected error submitting form: $e');
      rethrow;
    }
  }

  /// Orchestrates the entire process: upload photos, then submit form with URLs.
  /// 'photoFileNames' represents a list of file paths/names. In Flutter, this would be List<File>.
  Future<Map<String, dynamic>?> processFormWithPhotos(
      List<String> photoFileNames, // In Flutter, this would be List<File>
      Map<String, dynamic> initialFormData,
      ) async {
    try {
      List<String> uploadedPhotoUrls = [];

      // 1. Upload each photo sequentially
      for (String fileName in photoFileNames) {
        final url = await uploadPhoto(fileName);
        uploadedPhotoUrls.add(url);
      }

      print('All photos uploaded. URLs: $uploadedPhotoUrls');

      // 2. Prepare the final form data with photo URLs
      Map<String, dynamic> finalFormData = {
        ...initialFormData, // Include initial form data
        'photo_urls': uploadedPhotoUrls, // Add the list of uploaded photo URLs
      };

      // 3. Submit the form data with photo URLs
      final submissionResponse = await submitFormDataWithPhotos(finalFormData);

      return submissionResponse;
    } catch (e) {
      print('Error in processFormWithPhotos: $e');
      return null;
    }
  }
}

// --- Example Usage ---
void main() async {
  final apiService = ApiService();

  // Simulate photo files (in a real Flutter app, these would be dart:io.File objects)
  List<String> selectedPhotos = [
    'image_001.jpg',
    'selfie_2025.png',
    'document_scan.pdf',
  ];

  // Simulate initial form data
  Map<String, dynamic> postData = {
    'title': 'My New Post',
    'description': 'This is a description of my new post with some images.',
    'category': 'Travel',
    'tags': ['nature', 'adventure'],
  };

  print('\n--- Attempting to upload photos and submit form ---');
  final result = await apiService.processFormWithPhotos(selectedPhotos, postData);

  if (result != null) {
    print('\nSuccessfully processed form with photos:');
    print(result);
  } else {
    print('\nFailed to process form with photos.');
  }

  // --- Mocking Dio responses for demonstration purposes ---
  // In a real application, these would be actual network calls.
  // To make this example runnable without actual network requests,
  // you can add a mock adapter to Dio.
  // This part is for internal demonstration and would typically be handled
  // by a testing framework or a dedicated mock server in a real project.
  apiService._dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      if (options.path.contains('/upload')) {
        // Simulate a successful upload response
        final fileName = (options.data as FormData).files.first.key; // Assuming single file upload
        return handler.resolve(Response(
          requestOptions: options,
          data: {'url': 'https://mockcdn.example.com/uploaded/$fileName'},
          statusCode: 200,
        ));
      } else if (options.path.contains('/submit_form')) {
        // Simulate a successful form submission response
        return handler.resolve(Response(
          requestOptions: options,
          data: {'status': 'success', 'message': 'Form submitted!', 'received_data': options.data},
          statusCode: 200,
        ));
      }
      return handler.next(options); // Continue with actual request if not mocked
    },
  ));

  // Re-run the example with the mock interceptor active
  print('\n--- Re-attempting with mock interceptor ---');
  final resultWithMock = await apiService.processFormWithPhotos(selectedPhotos, postData);
  if (resultWithMock != null) {
    print('\nSuccessfully processed form with photos (mocked):');
    print(resultWithMock);
  } else {
    print('\nFailed to process form with photos (mocked).');
  }
}
