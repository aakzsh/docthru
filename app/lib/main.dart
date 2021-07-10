import 'package:docthru/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notifications",
  "description go brrr",
  importance: Importance.high,
  playSound: true,
);
final auth = FirebaseAuth.instance;
String email, password;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingbackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("bg message hehe ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingbackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    channel.id, channel.name, channel.description,
                    color: Colors.amber,
                    playSound: true,
                    icon: '@mipmap/ic_launcher')));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("new notif");
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: Column(
                  children: <Widget>[Text(notification.body)],
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.medical_services_outlined),
                    Text("Docthru",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold))
                  ],
                ),
                Center(
                  child: MaterialButton(
                    onPressed: () {
                      flutterLocalNotificationsPlugin.show(
                          0,
                          "testing",
                          "lol shoulda work",
                          NotificationDetails(
                              android: AndroidNotificationDetails(
                                  channel.id, channel.name, channel.description,
                                  color: Colors.red,
                                  importance: Importance.high,
                                  icon: '@mipmap/ic_launcher',
                                  playSound: true)));
                    },
                    child: Text("Button"),
                  ),
                )
              ],
            )));
  }
}

login(context) {
  return Column(
    children: <Widget>[
      TextField(
        onChanged: (text) {
          email = text;
        },
      ),
      TextField(
        obscureText: true,
        onChanged: (text) {
          password = text;
        },
      ),
      MaterialButton(
          child: Text("Login"),
          onPressed: () {
            auth
                .signInWithEmailAndPassword(email: email, password: password)
                .then((result) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            }).catchError((err) {
              print(err.message);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text(err.message),
                      actions: [
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            });
          })
    ],
  );
}
