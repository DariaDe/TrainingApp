import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:training_application/models/user.dart';
import 'package:training_application/widget/user_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'user_info_screen.dart';
import 'package:training_application/state/inherited_application_state.dart';

//color palette
const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  int selectedIndex = 0;
  final ScrollController _controller = ScrollController();

  bool _atTheBottom = false;
  int page = 1;

  List<User> users = [];

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemtap(int index) {
    setState(() {
      this.selectedIndex = index;
      if (this.selectedIndex == 1) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen()));
      }

      if (this.selectedIndex == 2) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SettingsScreen()));
      }
    });
  }

  _onScroll() {
    if (_controller.position.maxScrollExtent == _controller.position.pixels) {
      if (!_atTheBottom) {
        setState(() {
          _atTheBottom = !_atTheBottom;
          loadData();
        });
      }
    }
  }

  bool isLoading = false;
  bool isLoadingFirst = false;
  int totalCount = 1;

  loadData() async {
    print('Meee');
    print(page);
    if (page == 1) {
      isLoadingFirst = true;
      print(isLoadingFirst);
      users = await InheritedAplicationState.of(context).getUsers(page);
      totalCount = await InheritedAplicationState.of(context).getPagesCount();

      isLoadingFirst = false;
      print(isLoadingFirst);
    }

    print('total pages - ${totalCount}');
    if (_atTheBottom) {
      if (page < totalCount) {
        page++;
        print('${page} - page for second time');
        print(isLoadingFirst);
        isLoading = true;
        List<User> newUsers =
            await InheritedAplicationState.of(context).getUsers(page);
        setState(() {
          users.addAll(newUsers);
          isLoading = false;
        });
      }
    }

    return users;
  }

  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: loadData(),
          builder: (context, snapshot) {
            print(snapshot.connectionState);
            print('${isLoadingFirst} - in main');

            if (isLoadingFirst && !snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              print(snapshot.connectionState);
              return Column(
                children: [
                  InheritedAplicationState.of(context).currentUser.first_name ==
                              null &&
                          InheritedAplicationState.of(context)
                                  .currentUser
                                  .last_name ==
                              null
                      ? Container()
                      : SafeArea(
                          child: Container(
                              padding: EdgeInsets.only(left: 16.0),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 16.0,
                                      color: Color(0xFF3C3A36),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 3.0),
                                  Text(
                                    "${InheritedAplicationState.of(context).currentUser.first_name} ${InheritedAplicationState.of(context).currentUser.last_name}",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 32.0,
                                      color: Color(0xFF3C3A36),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                  Expanded(
                    flex: 5,
                    child: ListView.builder(
                        controller: _controller,
                        itemCount: snapshot.data.length + 1,
                        itemBuilder: (context, index) {
                          var user = User();
                          if (index == snapshot.data.length) {
                            if (page != totalCount) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                            return Container();
                          } else {
                            user = snapshot.data[index];

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0, bottom: 16.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double>
                                                  secondaryAnimation) {
                                            return UserInfoScreen(user: user);
                                          },
                                          transitionsBuilder:
                                              (BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                  Widget child) {
                                            return SlideTransition(
                                              position: new Tween<Offset>(
                                                begin: const Offset(0.0, 1.0),
                                                end: Offset.zero,
                                              ).animate(animation),
                                              child: new SlideTransition(
                                                position: new Tween<Offset>(
                                                  begin: Offset.zero,
                                                  end: const Offset(0.0, 1.0),
                                                ).animate(secondaryAnimation),
                                                child: FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                              ),
                                            );
                                          },
                                        ));
                                  },
                                  child: Container(
                                    child: UserTile(user: user),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.0, color: Color(0xFFBEBAB3)),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.0),
                                      ),
                                    ),
                                  )),
                            );
                          }
                        }),
                  ),
                ],
              );
            }
          }),
    );
  }
}
