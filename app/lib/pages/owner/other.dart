// import 'package:flushbar/flushbar.dart';
// import 'package:app/pages/auth/chooseform.dart';
import 'package:app/pages/auth/service/auth_service.dart';
import 'package:app/pages/owner/teams.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:email_launcher/email_launcher.dart';

class Other extends StatelessWidget {
  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    to: ['shulavkarki888@gmail.com'],
    cc: ['cc@example.com'],
    bcc: ['bcc@example.com'],
    // attachmentPaths: ['/path/to/attachment.zip'],
    // isHTML: false,
  );
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[300],
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading:
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //       'https://www.woolha.com/media/2020/03/eevee.png'),
                    // ),
                    const Icon(Icons.info),
                title: Text('About'),
                // trailing: Icon(Icons.time_to_leave),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: Text('Share'),
                // trailing: Icon(Icons.time_to_leave),
                onTap: () {
                  Share.share('https:google.com');
                },
              ),
              ListTile(
                leading: const Icon(Icons.group),
                title: Text('Teams'),
                // trailing: Icon(Icons.time_to_leave),
                onTap: () {
                  // EmailLauncher.launch(email);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Team()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.policy),
                title: Text('Policy'),
                // trailing: Icon(Icons.time_to_leave),
                onTap: () {},
              ),
              ListTile(
                // tileColor: Colors.cyan[],
                hoverColor: Colors.amber,
                leading: const Icon(
                  Icons.logout,
                  color: Colors.blueGrey,
                ),
                title: Text('Logout'),
                // trailing: Icon(Icons.time_to_leave),
                onTap: () {
                  context.read<AuthenticationProvider>().signOut();
                  Navigator.pop(context, ModalRoute.withName("/"));
                  // Navigator.pop(context, false);
                  // Navigator.pushAndRemoveUntil(context, , (route) => false);
                },
              ),
            ],
          ),
        ));
  }
}
