import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'google_sign_in.dart';
import 'Colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google Sign-In Demo',
        theme: ThemeData(
          backgroundColor: Colors.transparent,
        ),
        home: Consumer<GoogleSignInProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(
                title: SelectableText('Testing'),
                backgroundColor: MyColors.tu,
              ),
              drawer: Theme(
                data: Theme.of(context).copyWith(canvasColor: MyColors.tb),
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        child: UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            color: MyColors.tu,
                          ),
                          accountName: Text(provider.name ?? ''),
                          accountEmail: Text(provider.email ?? ''),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage:
                                NetworkImage(provider.photoUrl ?? ''),
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Item 1'),
                        onTap: () {
                          // TODO: Handle drawer item tap
                        },
                      ),
                      ListTile(
                        title: Text('Item 2'),
                        onTap: () {
                          // TODO: Handle drawer item tap
                        },
                      ),
                    ],
                  ),
                ),
              ),
              body: Center(
                child: provider.name != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(provider.photoUrl!),
                            radius: 50,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Welcome ${provider.name}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Email: ${provider.email}',
                            style: TextStyle(fontSize: 18),
                          ),
                          ElevatedButton(
                            child: Text('Sign Out'),
                            onPressed: () {
                              provider.signOut();
                            },
                          ),
                        ],
                      )
                    : ElevatedButton(
                        child: Text('Sign In with Google'),
                        onPressed: () {
                          provider.signIn();
                        },
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
