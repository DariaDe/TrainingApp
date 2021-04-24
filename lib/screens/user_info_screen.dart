import 'package:flutter/material.dart';
import 'package:training_application/widget/custom_button.dart';

const kTextColor = Color(0xFF3C3A36);
const kBottomAppBarColor = Color(0xFFBEBAB3);
const kBtnColor = Color(0xFF3789AC);

class UserInfoScreen extends StatefulWidget {
  final int cardIndex;

  const UserInfoScreen({Key key, this.cardIndex}) : super(key: key);
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'userCard',
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              "Mr.Smith",
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: kTextColor,
              ),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0.0,
            leading: Row(
              children: [
                SizedBox(
                  width: 16.0,
                ),
                CustomButton(
                  icon: Icons.arrow_back_ios_rounded,
                  onButtonTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )),
        backgroundColor: Colors.white,
        body: UserInfoWidget(),
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset('images/Illustration.png')),
        SizedBox(height: 40.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 12.0),
          child: Text(
            'About something',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 12.0),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non purus faucibus tortor auctor pretium. Sed quis volutpat nisl, vel cursus dui. Vestibulum vitae lectus mi. Donec nec sapien varius, sollicitudin leo ac, vulputate nisl. Donec ut interdum eros, eget eleifend turpis. Aliquam sit amet purus ut metus tempor aliquet at nec leo. ',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: kTextColor,
            ),
          ),
        ),
        SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 12.0),
          child: Text(
            'Duration',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: kTextColor,
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 12.0),
          child: Text(
            '1 h 30 min',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: kTextColor,
            ),
          ),
        ),
        SizedBox(height: 51.0),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
            width: double.infinity,
            height: 56.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kBtnColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  )

                  // background
                  ),
              onPressed: () {},
              child: Text(
                'Add to cart',
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
