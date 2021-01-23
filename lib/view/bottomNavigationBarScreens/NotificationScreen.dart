import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:labelize/model/userModel.dart';
import 'package:labelize/services/constants.dart';
import 'package:labelize/services/database.dart';
import 'package:labelize/services/saveNotificationFirebase.dart';
import 'package:labelize/widgets/CustomToast.dart';
import 'package:labelize/widgets/Helper.dart';
import 'package:labelize/services/pushNotificationService.dart';

import '../../project_theme.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification';

  // NotificationScreen(GlobalKey<NavigatorState> navigatorKey);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final SaveNotificationFirebase saveNotificationFirebase =
      SaveNotificationFirebase();

  DatabaseService database = DatabaseService(uId: Constants.userId);
  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('user');

  String messageTitle = '';
  String body = '';
  int date = 0;
  bool hasData = false;

  // getMessage() {
  //   _fcm.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //
  //       body = message['notification']['body'];
  //
  //       if (body != null)
  //         setState(() {
  //           messageTitle = message['notification']['title'];
  //           body = message['notification']['body'];
  //         });
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //       body = message['data']['body'];
  //
  //       if (body != null)
  //         setState(() {
  //           // hasData = true;
  //           messageTitle = message['data']['title'];
  //           body = message['data']['body'];
  //           date = message['data']['google.sent_time'];
  //         });
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //       body = message['data']['body'];
  //
  //       if (body != null)
  //         setState(() {
  //           // hasData = true;
  //           messageTitle = message['data']['title'];
  //           body = message['data']['body'];
  //           date = message['data']['google.sent_time'];
  //         });
  //     },
  //   );
  // }

  void initState() {
    super.initState();

    // saveNotificationFirebase.SaveNotification();
    //  getMessage();
    _fcm.subscribeToTopic('everyone');

    // print(NotificationMsgs.messageTitle);
    if (mounted) {
      setState(() {
        if (NotificationMsgs.messageTitle != null) {
          messageTitle = NotificationMsgs.messageTitle;
          body = NotificationMsgs.body;
          date = NotificationMsgs.date;
          // hasData = true;
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return ColorfulSafeArea(
      child: Scaffold(
          body: StreamBuilder(
              stream: database.userStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<UserModel> use = snapshot.data;
                int index = 0;
                for (int i = 0; i < use.length; i++) {
                  if (Constants.user.email == use[i].email) {
                    index = i;
                    break;
                  }
                }
                UserModel data = snapshot.data[index];

                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                        padding: const EdgeInsets.all(30),
                        color: ProjectTheme.navigationBackgroundColor,
                        height: _height * 0.85,
                        child: Column(
                          children: [
                            Text(
                              'Notifications',
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w300),
                            ),
                            !hasData
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        top: _height * 0.3, right: 20),
                                    child: Text(
                                      'No Notiifications',
                                      style: TextStyle(fontSize: 20),
                                    ))
                                :
                                // ListView.builder(
                                //         shrinkWrap: true,
                                //         physics: BouncingScrollPhysics(),
                                //         itemCount: ,
                                //         itemBuilder: (BuildContext context, index) {
                                //           return
                                ListTile(
                                    title: Text('${data.notifications[1]['messageTitle']}'),
                                    subtitle: Text('${data.notifications[1]['body']}'),
                                    trailing: Text(
                                        '${Helper.getDateNtime(DateTime.fromMicrosecondsSinceEpoch(data.notifications[1]['createdAt'] * 1000))}'),
                                  )
                            // }),
                          ],
                        )

                        //     ListTile(
                        //       title: Text('Notification 2'),
                        //       subtitle: Text('content 2'),
                        //       trailing: Text(
                        //         Helper.getDateNtime(
                        //           DateTime.now(),
                        //         ),
                        //       ),
                        //     ),
                        //     ListTile(
                        //       title: Text('Notification 3'),
                        //       subtitle: Text('content 3'),
                        //       trailing: Text(
                        //         Helper.getDateNtime(
                        //           DateTime.now(),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // )
                        ),
                  ],
                );
              })),
    );
  }
}
