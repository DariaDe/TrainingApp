import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:training_application/models/user.dart';
import 'package:training_application/widget/user_tile.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'user_info_screen.dart';
import 'package:training_application/state/inherited_application_state.dart';
import 'package:training_application/widget/custom_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//color palette
const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>
    with AutomaticKeepAliveClientMixin<UsersScreen> {
  int selectedIndex = 0;
  final ScrollController _controller = ScrollController();

  bool _atTheBottom = false;
  int page = 1;

  List<User> users = [];
  List<User> usersFromDb = [];

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
    _checkInternetConnection();
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

  bool _isConnected = false;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty && _isConnected == false) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
      if (_isConnected == true) {
        setState(() {
          _isConnected = false;
        });

        print(err);
      }
    }
  }

  loadData() async {
    print('Meee');
    print(page);

    if (_isConnected) {
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
    } else {
      isLoadingFirst = true;
      usersFromDb = await InheritedAplicationState.of(context).getAllUsers();
      isLoadingFirst = false;
      return usersFromDb;
    }
  }

  String fullName;
  List<User> searchedUsers = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _controller.addListener(_onScroll);

    super.initState();
    _checkInternetConnection();
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
                    InheritedAplicationState.of(context)
                                    .currentUser
                                    .first_name ==
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
                                    searchedUsers.isEmpty
                                        ? Text(
                                            "Hello,",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 16.0,
                                              color: Color(0xFF3C3A36),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        : Container(),
                                    searchedUsers.isEmpty
                                        ? SizedBox(height: 3.0)
                                        : Container(),
                                    searchedUsers.isEmpty
                                        ? Text(
                                            "${InheritedAplicationState.of(context).currentUser.first_name} ${InheritedAplicationState.of(context).currentUser.last_name}",
                                            style: TextStyle(
                                              fontFamily: 'Rubik',
                                              fontSize: 32.0,
                                              color: Color(0xFF3C3A36),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(height: 12.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 16.0, bottom: 16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              searchedUsers.isNotEmpty
                                                  ? Expanded(
                                                      child: CustomButton(
                                                        icon: Icons
                                                            .arrow_back_ios_rounded,
                                                        padding: 15.0,
                                                        onButtonTap: () {
                                                          setState(() {
                                                            searchedUsers = [];
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                              Expanded(
                                                flex: 6,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: TextFormField(
                                                    controller:
                                                        TextEditingController(
                                                            text: fullName),
                                                    onChanged: (value) {
                                                      fullName = value;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Search by User Name',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        borderSide: BorderSide(
                                                          color:
                                                              kBorderFormColor,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      suffixIcon: IconButton(
                                                        icon: SvgPicture.asset(
                                                            'images/search.svg',
                                                            color: Color(
                                                                0xFF3C3A36)),
                                                        onPressed: () async {
                                                          List<User> result =
                                                              await InheritedAplicationState
                                                                      .of(
                                                                          context)
                                                                  .getSearchResult(
                                                                      fullName);

                                                          setState(() {
                                                            searchedUsers =
                                                                result;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          searchedUsers.isNotEmpty
                                              ? SizedBox(height: 12.0)
                                              : Container(),
                                          searchedUsers.isNotEmpty
                                              ? Text(
                                                  '${searchedUsers.length} Results',
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 24.0,
                                                    color: Color(0xFF3C3A36),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                    Expanded(
                      flex: 5,
                      child: searchedUsers.isEmpty
                          ? ListView.builder(
                              controller: _controller,
                              itemCount: snapshot.data.length + 1,
                              itemBuilder: (context, index) {
                                var user = User();
                                if (index == snapshot.data.length) {
                                  if (page != totalCount) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: CircularProgressIndicator()),
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
                                                pageBuilder: (BuildContext
                                                        context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secondaryAnimation) {
                                                  return UserInfoScreen(
                                                      user: user);
                                                },
                                                transitionsBuilder:
                                                    (BuildContext context,
                                                        Animation<double>
                                                            animation,
                                                        Animation<double>
                                                            secondaryAnimation,
                                                        Widget child) {
                                                  return SlideTransition(
                                                    position: new Tween<Offset>(
                                                      begin: const Offset(
                                                          0.0, 1.0),
                                                      end: Offset.zero,
                                                    ).animate(animation),
                                                    child: new SlideTransition(
                                                      position: new Tween<
                                                          Offset>(
                                                        begin: Offset.zero,
                                                        end: const Offset(
                                                            0.0, 1.0),
                                                      ).animate(
                                                          secondaryAnimation),
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
                                          child: UserTile(
                                              user: user,
                                              isConnected: _isConnected),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: Color(0xFFBEBAB3)),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                        )),
                                  );
                                }
                              })
                          : ListView.builder(
                              itemCount: searchedUsers.length,
                              itemBuilder: (BuildContext context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, right: 16.0, bottom: 16.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (BuildContext
                                                      context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation) {
                                                return UserInfoScreen(
                                                    user: searchedUsers[index]);
                                              },
                                              transitionsBuilder: (BuildContext
                                                      context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
                                                  Widget child) {
                                                return SlideTransition(
                                                  position: new Tween<Offset>(
                                                    begin:
                                                        const Offset(0.0, 1.0),
                                                    end: Offset.zero,
                                                  ).animate(animation),
                                                  child: new SlideTransition(
                                                    position: new Tween<Offset>(
                                                      begin: Offset.zero,
                                                      end: const Offset(
                                                          0.0, 1.0),
                                                    ).animate(
                                                        secondaryAnimation),
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
                                        child: UserTile(
                                            user: searchedUsers[index],
                                            isConnected: _isConnected),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0,
                                              color: Color(0xFFBEBAB3)),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12.0),
                                          ),
                                        ),
                                      )),
                                );
                              }),
                    ),
                  ],
                );
              }
            }));
  }
}
