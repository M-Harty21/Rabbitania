import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Noticeboard/noticeboardHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardEditThread.dart';

class NoticeBoardThreads {
  final List<dynamic> threadList;

  NoticeBoardThreads({
    required this.threadList,
  });

  factory NoticeBoardThreads.fromJson(Map<String, dynamic> json) {
    return NoticeBoardThreads(
      threadList: json["noticeBoard"],
    );
  }
}

class Thread {
  final int threadId;
  final String threadTitle;
  final String threadContent;
  final int minEmployeeLevel;
  final String imageUrl;
  final int permittedUserRoles;
  final int userId;

  Thread({
    required this.threadId,
    required this.threadTitle,
    required this.threadContent,
    required this.minEmployeeLevel,
    required this.imageUrl,
    required this.permittedUserRoles,
    required this.userId,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      threadId: json['threadId'],
      threadTitle: json['threadTitle'],
      threadContent: json['threadContent'],
      minEmployeeLevel: json['minEmployeeLevel'],
      imageUrl: json['imageUrl'],
      permittedUserRoles: json['permittedUserRoles'],
      userId: json['userId'],
    );
  }
}

class NoticeboardHomeCard extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theImageURL;

  const NoticeboardHomeCard(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.theImageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      child: InkWell(
        onTap: () {
          noticeID = this.id;
          UtilModel.route(() => Notice(), context);
        },
        child: Card(
          color: Color.fromRGBO(57, 57, 57, 25),
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
                // leading: Icon(
                //   Icons.announcement_outlined, size: 45,
                //   color: Color.fromRGBO(171, 255, 79, 1),),
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    theThreadTitle,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  theThreadContent,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                    minWidth: 500,
                    maxWidth: double.infinity,
                    minHeight: 0.0,
                    maxHeight: 300),
                padding: EdgeInsets.only(top: 5),
                child: Image.memory(Base64Decoder().convert(theImageURL),
                    fit: BoxFit.cover, width: 10000),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class singleNoticeCardObj extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String imageFile;

  const singleNoticeCardObj(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color.fromRGBO(57, 57, 57, 1),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          children: [
            Container(
                child: Image.memory(
              Base64Decoder().convert(imageFile),
              fit: BoxFit.fill,
            )),
            ListTile(
              contentPadding:
                  EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
              title: Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  theThreadTitle,
                  style: TextStyle(
                      letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                ),
              ),
              subtitle: Text(
                theThreadContent,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class noticeboardEditCard extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theThreadImageFile;

  const noticeboardEditCard(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.theThreadImageFile});

  @override
  Widget build(BuildContext context) {
    titleControllerNoticeboardEdit.text = theThreadTitle;
    contentControllerNoticeboardEdit.text = theThreadContent;
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Column(
          children: [
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: titleControllerNoticeboardEdit,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
            TextFormField(
              minLines: 1,
              maxLines: 20,
              style: TextStyle(color: Colors.white),
              controller: contentControllerNoticeboardEdit,
              cursorColor: Color.fromRGBO(171, 255, 79, 1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                ),
                labelText: 'Content',
                labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          iconSize: 50,
                          color: Color.fromRGBO(171, 255, 79, 1),
                          tooltip: "Add Image",
                          onPressed: () async {
                            await noticeboardEditGetFromGallery();
                            UtilModel.route(
                                () => NoticeBoardEditThread(), context);
                          }),
                      Text(
                        "Add Image",
                        style:
                            TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: noticeboardEditIsImageWidget(theThreadImageFile),
            ),
          ],
        ),
      ),
    );
  }
}