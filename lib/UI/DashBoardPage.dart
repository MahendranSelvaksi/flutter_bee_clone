import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter1/UI/LoginPage.dart';
import 'package:flutter1/UI/gate_check_form.dart';
import 'package:flutter1/main.dart';
import 'package:flutter1/repository/AllFormData.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/APITokenDetails.dart';
import '../utils/PermissionHandler.dart';
import '../utils/Utils.dart';
import 'ToggleButton.dart';

import 'package:permission_handler/permission_handler.dart';

const List<Widget> status = <Widget>[Text('Inactive'), Text('Active')];

PermissionHandler mPermissionHandler = PermissionHandler();

final PageController pageController = PageController(initialPage: 0);
int selectedIndex = 0;

const Color _inActiveColor = Colors.grey;
const Color _activeColor = Colors.green;
List<Widget> status1 = <Widget>[];

const TextStyle optionStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);
const List<Widget> _widgetOptions = <Widget>[
  Text('Index 0: Home', style: optionStyle),
  Text('Index 1: Business', style: optionStyle),
  Text('Index 2: School', style: optionStyle),
];

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => DashBoardState();
}

class DashBoardState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.deepPurple,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Container(
            alignment: Alignment.topLeft,
            child: DashBoardHeader(),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    selectedIndex = 0;
                    onTabTapped(selectedIndex);
                    pageController.jumpToPage(selectedIndex);
                  },
                  icon: Icon(
                    Icons.home,
                    color:
                        selectedIndex == 0
                            ? Colors.purple.shade800
                            : Colors.grey,
                  ),
                ),
                Spacer(),
                Spacer(),
                IconButton(
                  onPressed: () {
                    selectedIndex = 1;
                    onTabTapped(selectedIndex);
                    pageController.jumpToPage(selectedIndex);
                  },
                  icon: Icon(
                    Icons.menu,
                    color:
                        selectedIndex == 1
                            ? Colors.purple.shade800
                            : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;

      ///call your PageController.jumpToPage(index) here too, if needed
    });
  }
}

class _DashBoardHeader extends State<DashBoardHeader> {
  String selectedState = "You are inactive now";
  Color activeInActiveColor = _inActiveColor;

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await [
          Permission.storage, // Or Permission.photos for iOS / newer Android
          Permission.camera,
        ].request();

    if (statuses[Permission.storage]!
        .isGranted /*|| statuses[Permission.photos]!.isGranted*/ ) {
      // Storage permission granted
      await Permission.storage.status;
      /*  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission granted'),
        ),
      );*/
    }
    if (statuses[Permission.camera]!.isGranted) {
      // Camera permission granted
      await Permission.camera.status;
      /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera permission granted'),
        ),
      );*/
    }
  }

  @override
  void initState() {
    super.initState();
    mPermissionHandler.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginbg.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to Bee ${objectBox.getLoginData(1)?.firstName.toString()}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              selectedState,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ), //Text container
                      ),
                    ), // Welcome text
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage: AssetImage(
                                "assets/images/mask_group.png",
                              ),
                            ),
                            Positioned(
                              right: 2,
                              bottom: 8,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                height: 12,
                                width: 12,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        selectedState == "You are inactive now"
                                            ? _inActiveColor
                                            : _activeColor,
                                    shape: BoxShape.circle,
                                  ),
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ),
                          ],
                        ), // Profile indicator
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ActiveInActiveToggle(
                  onActiveStatusChanged:
                      (data) => setState(() => selectedState = data),
                  selectedState: selectedState,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                Center(child: QuickLinksSection()),
                Center(child: MenuSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashBoardHeader extends StatefulWidget {
  final List<bool> _selectedStates = <bool>[true, false];

  @override
  State<DashBoardHeader> createState() => _DashBoardHeader();
}

class _QuickLinksSection extends State<QuickLinksSection> {
  Utils utils = Utils();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.orangeAccent.shade400,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Gate Check",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    String formId =
                        objectBox.getGateCheckFormForToday().toString();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GateCheck(formId: formId),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 2.0, color: Colors.white),
                  ),
                  child: const Text(
                    'Check Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Quick Links",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              primary: false,
              childAspectRatio: 0.8,
              crossAxisSpacing: 4.0,
              // Reduced horizontal spacing
              mainAxisSpacing: 4.0,
              // Reduced vertical spacing
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(Utils.dashBoardMenu.length, (index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Utils.dashBoardMenuIcons[index],
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(height: 15),
                          Text(
                            Utils.dashBoardMenu[index],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }




}

class QuickLinksSection extends StatefulWidget {
  const QuickLinksSection({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QuickLinksSection();
  }
}

class _MenuSelection extends State<MenuSection> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(2),
      itemCount: Utils.menuList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 2.5,top: 2.5),
          child: Container(
            height: 50,
            child: InkWell(
              child: Container(
                child: Row(
                  children: [
                    Image.asset(
                      Utils.menuListIcons[index],
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(width: 15),
                    Text(
                      Utils.menuList[index],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                if(index==Utils.menuList.length-1){
                  _showMyDialog();
                }
              },
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
  Future<void> removeDataFromSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('login_api_response');
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Are you want to Logout from App?')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                objectBox.deleteLoginData(1);
                removeDataFromSession();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MenuSelection();
  }
}
