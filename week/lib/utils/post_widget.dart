import 'dart:io';
import 'package:flutter/material.dart';
import 'package:week/DatabaseHandler/DbHelper.dart';
import 'package:week/models/UserModel.dart';
import 'package:week/models/posts_model.dart';
import '../screens/postScreen.dart';

class PostWidget extends StatefulWidget {
  final UserModel user;
  final UserModel currentUser;
  final Publication pub;
  final Photo photo;
  const PostWidget(
      {Key? key,
      required this.user,
      required this.pub,
      required this.photo,
      required this.currentUser})
      : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  var dbHelper;
  bool loading = true;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    liked = false;
    dbHelper = DbHelper.instance;
    getComs();
    getNLike();
    debugPrint(widget.photo.photoId.toString());
  }

  var coms;
  var nLikes;

  void getNLike() async {
    debugPrint('getting like');

    var temp;
    var res = await dbHelper.getNLikes(widget.pub.publicationID);

    if (res != null) {
      temp = res.length;
    } else {
      temp = 0;
    }

    setState(() {
      nLikes = temp;
    });
  }

  void getComs() async {
    debugPrint('getting coms');
    var temp;
    var res = await dbHelper.getComments(widget.pub.publicationID);
    if (res != null) {
      temp = res.length;
    } else {
      temp = 0;
    }
    debugPrint(temp.toString());

    setState(() {
      coms = temp;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          width: double.infinity,
          height: 560,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 2),
                                    blurRadius: 6)
                              ]),
                          child: CircleAvatar(
                              child: ClipOval(
                            child: Image(
                              height: 50,
                              width: 50,
                              image: widget.user.imagePath == null
                                  ? const AssetImage(
                                          'assets/images/flutter_logo.png')
                                      as ImageProvider
                                  : FileImage(
                                      File(widget.user.imagePath.toString())),
                              fit: BoxFit.cover,
                            ),
                          )),
                        ),
                        title: Text(
                          widget.user.user_name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          widget.user.email,
                        ),
                        trailing: IconButton(
                            color: Colors.black,
                            onPressed: () => print('More'),
                            icon: const Icon(
                              Icons.more_horiz,
                            ))),
                    InkWell(
                        onDoubleTap: () {
                          setState(() {
                            liked = !liked;
                          });
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PostScreen(
                                      user: widget.user,
                                      pub: widget.pub,
                                      photo: widget.photo,
                                      currentUser: widget.currentUser)));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 5),
                                    blurRadius: 8)
                              ],
                              image: DecorationImage(
                                image: FileImage(
                                    File(widget.photo.image.toString())),
                                fit: BoxFit.fitWidth,
                              )),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: loading
                          ? SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              liked = !liked;
                                            });
                                          },
                                          icon: liked
                                              ? Icon(Icons.favorite_outlined)
                                              : Icon(Icons.favorite_border),
                                          iconSize: 30,
                                        ),
                                        Text(
                                          nLikes.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            /*
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PostScreen(
                                              post: posts[widget.index],
                                            ),
                                          ));*/
                                          },
                                          icon: const Icon(Icons.chat),
                                          iconSize: 30,
                                        ),
                                        Text(
                                          coms.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () => print('Save Post'),
                                  icon: const Icon(Icons.bookmark_border),
                                  iconSize: 30,
                                ),
                              ],
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
