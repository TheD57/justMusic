import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justmusic/values/constants.dart';

import '../components/profile_list_component.dart';
import '../main.dart';
import '../model/User.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  List<User> _listUsers = [];

  Future<void> updateList(String value) async {
    var newlistUsers = await MyApp.userViewModel.getUsersByUniqueId(value);
    setState(() {
      _listUsers = newlistUsers;
    });
  }

  Future<void> resetFullScreen() async {
    await SystemChannels.platform.invokeMethod<void>(
      'SystemChrome.restoreSystemUIOverlays',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 58),
          child: Container(
            height: double.infinity,
            color: bgAppBar,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Align(
                    child: Text(
                      "Ajouter des amis",
                      style:
                          GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(3.14159265),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 30,
                            width: 30,
                            child: const Image(
                              image: AssetImage("assets/images/return_icon.png"),
                              height: 8,
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          color: bgColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    autofocus: false,
                    controller: _textEditingController,
                    keyboardAppearance: Brightness.dark,
                    onEditingComplete: resetFullScreen,
                    onSubmitted: (value) async {
                      if (_textEditingController.text.isNotEmpty) {
                        updateList(value);
                      } else {
                        setState(() {
                          _listUsers = [];
                        });
                      }
                    },
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.plusJakartaSans(color: grayText),
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: grayColor,
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: grayColor),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        contentPadding:
                            const EdgeInsets.only(top: 0, bottom: 0, left: defaultPadding, right: defaultPadding),
                        fillColor: searchBarColor,
                        filled: true,
                        focusColor: grayText,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: grayColor),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        hintText: 'Chercher un ami',
                        hintStyle: GoogleFonts.plusJakartaSans(color: grayHint)),
                  ),
                ),
              ),
              Flexible(
                  child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(scrollbars: true),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                        itemCount: _listUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                child: ProfileListComponent(user: _listUsers[index])),
                          );
                        },
                      )))
            ],
          ),
        ));
  }
}
