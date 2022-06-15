import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AAD OAuth Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'AAD OAuth Home'),
      // navigatorKey: navigatorKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Must configure flutter to start the web server for the app on
  // the port listed below. In VSCode, this can be done with
  // the following run settings in launch.json
  // "args": ["-d", "chrome","--web-port", "8483"]
  static final Config configB2Ca = Config(
    // tenant: "YOUR_TENANT_NAME",
    // clientId: "YOUR_CLIENT_ID",
    // scope: "YOUR_CLIENT_ID offline_access",
    // redirectUri: "https://login.live.com/oauth20_desktop.srf",
    // clientSecret: "YOUR_CLIENT_SECRET",
    // isB2C: true,
    // policy: "YOUR_USER_FLOW___USER_FLOW_A",
    // tokenIdentifier: "UNIQUE IDENTIFIER A",
    // navigatorKey: navigatorKey,
    tenant: "internloginmicrosoft",
    clientId: "5d6dba2e-0710-4dbb-95b5-d404af0c51b1",
    scope: "5d6dba2e-0710-4dbb-95b5-d404af0c51b1 offline_access",
    clientSecret: "AEI8Q~NXSrUU4j-iaIvNViFwOutl7mfTS1hv2bNS",

    isB2C: true,
    redirectUri: "https://jwt.ms",

    policy: "B2C_1_signupsignin1",
    // tokenIdentifier: "UNIQUE IDENTIFIER A",

    navigatorKey: navigatorKey,
  );

  //error
  final AadOAuth oauth = AadOAuth(configB2Ca);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'AzureAD OAuth',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.launch),
          //   title: Text('Login'),
          //   onTap: () {
          //     login();
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.delete),
          //   title: Text('Logout'),
          //   onTap: () {
          //     logout();
          //   },
          // ),
        ],
      ),
    );
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void login() async {
    try {
      await oauth.login();
      var accessToken = await oauth.getAccessToken();
      showMessage('Logged in successfully, your access token: $accessToken');
    } catch (e) {
      showError(e);
    }
  }

  void logout() async {
    try {
      await oauth.logout();
      showMessage('Logged out');
    } catch (e) {
      showError(e);
    }
  }
}
