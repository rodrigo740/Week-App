import 'package:flutter/material.dart';

import '../Screens/following_screen.dart';

class NumbersWidget extends StatelessWidget {
  final String nFollowing;
  final bool profile;
  final String user_id;

  const NumbersWidget(this.nFollowing, this.profile,this.user_id,  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4.8', 'Ranking'),
          buildDivider(),
          buildButton(context, nFollowing, 'Following'),
          buildDivider(),
          buildButton(context, '2', 'Followers'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {
          if(profile)
          {
            print("true profile");
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => FollowingScreen(user_id: user_id,))));
          }
          else
          {
            print("false profile");
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => FollowingScreen(user_id: user_id,))));

          }
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
