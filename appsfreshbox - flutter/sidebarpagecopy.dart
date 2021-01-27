// import 'dart:convert';
// import 'dart:async';
// import 'package:appsfreshbox/LoginPage.dart';
// import 'package:appsfreshbox/ChangePasswordPage.dart';
// import 'package:appsfreshbox/Picker/pages/TabBarsPickerPage.dart';
// import 'package:appsfreshbox/Picker/pages/TabBarsPickerPendingPage.dart';
// import 'package:appsfreshbox/Procurement/pages/HomeProcPage.dart';
// import 'package:appsfreshbox/Procurement/pages/ListProcPage.dart';
// import 'package:appsfreshbox/Procurement/pages/TabBarHistoryPage.dart';
// import 'package:appsfreshbox/Qc/pages/HomeQcPage.dart';
// import 'package:appsfreshbox/Picker/pages/HomePickerPage.dart';
// import 'package:appsfreshbox/Qc/pages/TabBarsQcPage.dart';
// import 'package:appsfreshbox/Qc/pages/TabBarsQcPendingPage.dart';
// import 'package:appsfreshbox/Hrm/pages/HomeHrmPage.dart';
// import 'package:appsfreshbox/Receiving/pages/ConfrimReceivingPage.dart';
// import 'package:appsfreshbox/Receiving/pages/HomeReceivingPage.dart';
// import 'package:appsfreshbox/Services/Services.dart';
// import 'package:appsfreshbox/models/Datajson.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SideBarPageCopy extends StatefulWidget {
//   final int selectPage;
//   final String msg;
//   SideBarPageCopy({this.selectPage, this.msg});
//   @override
//   _SideBarPageCopyState createState() => _SideBarPageCopyState();
// }

// class _SideBarPageCopyState extends State<SideBarPageCopy> {
//   int index = 0;
//   String _name, _nik, _role;
//   // String tmpsaldo;
//   List<Widget> listQc = [
//     HomeQcPage(),
//     TabBarsQcPage(selectTab: 0),
//     TabBarsQcPendingPage(selectTab: 0),
//     HomeHrmPage()
//   ];
//   List<Widget> listPicker = [
//     HomePickerPage(),
//     TabBarsPickerPage(selectTab: 0),
//     TabBarsPickerPendingPage(selectTab: 0),
//     HomeHrmPage()
//   ];
//   List<Widget> listDriver = [Container(), Container(), Container()];
//   List<Widget> listHrm = [HomeHrmPage(), Container(), Container()];
//   List<Widget> listProcurement = [
//     HomeProcPage(),
//     ListProcPage(),
//     TabBarHistoryPage(
//       selectTab: 0,
//     ),
//     HomeHrmPage()
//   ];
//   List<Widget> listReceiving = [
//     HomeReceivingPage(),
//     ConfrimReceivingPage(),
//     HomeHrmPage(),
//   ];
//   List<Dataorder> dataOrder = [];
//   bool isLoading = false;
//   int holdPick,
//       pendingPick,
//       confrimPick,
//       holdPickb2b,
//       pendingPickb2b,
//       confrimPickb2b;
//   int holdQc, pendingQc, confrimQc, holdQcb2b, pendingQcb2b, confrimQcb2b;
//   Timer _timer;
//   int tmpReject = 0;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   var body;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 10), (_timer) {
//       if (mounted) {
//         if (_role == "Pickers" || _role == "QC B2C" || _role == "QC B2B") {
//           _getPickerorder();
//           _getRejectorder();
//         }
//         _getNotif();
//       }
//     });
//     onTabTapped(widget.selectPage);
//     if (mounted) {
//       if (_role == "Pickers" || _role == "QC B2C" || _role == "QC B2B") {
//         _getPickerorder();
//         _getRejectorder();
//       }
//       _loadUserData();
//       _getNotif();
//     }
//   }

//   @override
//   void dispose() {
//     if (!mounted) {
//       _timer.cancel();
//     }
//     super.dispose();
//   }

//   void onTabTapped(int indx) {
//     setState(() {
//       index = indx;
//     });
//   }

//   _getNotif() async {
//     if (widget.msg != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) async {
//         await showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => new AlertDialog(
//             title: new Text("Pemberitahuan!!!"),
//             content: new Text(widget.msg),
//             actions: <Widget>[
//               new FlatButton(
//                 child: new Text("Ok"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       });
//     }
//   }

//   _loadUserData() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var user = jsonDecode(localStorage.getString('user'));
//     var role = jsonDecode(localStorage.getString('role'));

//     if (user != null) {
//       setState(() {
//         _name = user['name'];
//         _nik = user['nik'];
//         _role = role[0];
//         // tmpsaldo = user['procurement']['saldo'];
//       });
//     }
//   }

//   _getPickerorder() async {
//     var response = await Services().getPickerorder();
//     if (response.statusCode == 200) {
//       if (!mounted) return;
//       setState(() {
//         body = json.decode(response.body);
//         holdPick = body['holdpicker'];
//         pendingPick = body['pendingpicker'];
//         confrimPick = body['confrimpicker'];
//         holdQc = body['holdqc'];
//         pendingQc = body['pendingqc'];
//         confrimQc = body['confrimqc'];
//         holdPickb2b = body['holdpickerb2b'];
//         pendingPickb2b = body['pendingpickerb2b'];
//         confrimPickb2b = body['confrimpickerb2b'];
//         holdQcb2b = body['holdqcb2b'];
//         pendingQcb2b = body['pendingqcb2b'];
//         confrimQcb2b = body['confrimqcb2b'];
//         isLoading = true;
//       });
//     }
//   }

//   _getRejectorder() async {
//     var response = await Services().getRejectorder();
//     if (response.statusCode == 200) {
//       if (!mounted) return;
//       setState(() {
//         var body = json.decode(response.body);
//         tmpReject = body['reject'];
//         if (tmpReject > 0) {
//           WidgetsBinding.instance.addPostFrameCallback((_) async {
//             await showDialog<String>(
//               context: context,
//               builder: (BuildContext context) => new AlertDialog(
//                 title: new Text("Pemberitahuan!!!"),
//                 content: new Text(
//                     "Anda Memiliki $tmpReject Order Reject, Silakan Cek di Pending Order !!!"),
//                 actions: <Widget>[
//                   new FlatButton(
//                     child: new Text("Ok"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             );
//           });
//         }
//       });
//     }
//   }

//   _logout() async {
//     var res = await Services().logoutData();
//     var body = json.decode(res.body);
//     if (body['success'] == true) {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.remove('user');
//       localStorage.remove('token');
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => LoginPage()),
//           (Route<dynamic> route) => false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: (details) {
//         if (details.delta.dx > 0) {
//           _scaffoldKey.currentState.openDrawer();
//         }
//       },
//       child: SafeArea(
//         child: Scaffold(
//           key: _scaffoldKey,
//           appBar: AppBar(
//             title: _role == "QC B2C" || _role == "QC B2B"
//                 ? index == 0
//                     ? Text("Qc - Home")
//                     : index == 1
//                         ? Text("Qc - Hold Boxed")
//                         : index == 2
//                             ? Text("Qc - Pending Boxed")
//                             : Text("Attendance")
//                 : _role == "Pickers"
//                     ? index == 0
//                         ? Text("Picker - Home")
//                         : index == 1
//                             ? Text("Picker - Hold Pick")
//                             : index == 2
//                                 ? Text("Picker - Pending Pick")
//                                 : Text("Attendance")
//                     : _role == "Purchasing"
//                         ? index == 0
//                             ? Text('Home')
//                             : index == 1
//                                 ? Text('List No Procurement')
//                                 : index == 2
//                                     ? Text('History')
//                                     : Text('Attendance')
//                         : _role == "Receiving Staff"
//                             ? index == 0
//                                 ? Text('Receiving - Home')
//                                 : index == 1
//                                     ? Text('Receiving - Confirm')
//                                     : Text('Receiving - Attendance')
//                             : index == 0
//                                 ? Text("Attendance - Home")
//                                 : index == 1 ? Text(" - ") : Text(" - "),
//             backgroundColor: Colors.redAccent,
//           ),
//           body: isLoading
//               ? _role == "Pickers"
//                   ? listPicker[index]
//                   : _role == "QC B2C" || _role == "QC B2B"
//                       ? listQc[index]
//                       : null
//               : _role == "Purchasing"
//                   ? listProcurement[index]
//                   : _role == "Receiving Staff"
//                       ? listReceiving[index]
//                       : listHrm[index],
//           drawer: DrawerPage(
//             onTap: (ctx, i) {
//               // if (i == 5) {
//               //   _logout();
//               // } else {
//               setState(() {
//                 index = i;
//                 Navigator.pop(ctx);
//               });
//               // }
//             },
//             name: _name,
//             nik: _nik,
//             role: _role,
//             logout: () {
//               setState(() {
//                 _logout();
//               });
//             },
//             holdPick: holdPick,
//             pendingPick: pendingPick,
//             confrimPick: confrimPick,
//             holdQc: holdQc,
//             pendingQc: pendingQc,
//             confrimQc: confrimQc,
//             holdPickb2b: holdPickb2b,
//             pendingPickb2b: pendingPickb2b,
//             confrimPickb2b: confrimPickb2b,
//             holdQcb2b: holdQcb2b,
//             pendingQcb2b: pendingQcb2b,
//             confrimQcb2b: confrimQcb2b,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DrawerPage extends StatelessWidget {
//   final Function onTap, logout;
//   final String name, nik, token, role;
//   final int holdPick,
//       pendingPick,
//       confrimPick,
//       holdQc,
//       pendingQc,
//       confrimQc,
//       holdPickb2b,
//       pendingPickb2b,
//       confrimPickb2b,
//       holdQcb2b,
//       pendingQcb2b,
//       confrimQcb2b;

//   DrawerPage(
//       {this.onTap,
//       this.name,
//       this.nik,
//       this.role,
//       this.token,
//       this.logout,
//       this.holdPick,
//       this.pendingPick,
//       this.confrimPick,
//       this.holdQc,
//       this.pendingQc,
//       this.confrimQc,
//       this.holdPickb2b,
//       this.pendingPickb2b,
//       this.confrimPickb2b,
//       this.holdQcb2b,
//       this.pendingQcb2b,
//       this.confrimQcb2b});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: Drawer(
//         child: Column(
//           // padding: EdgeInsets.zero,
//           children: <Widget>[
//             Container(
//               width: MediaQuery.of(context).size.width * 0.8,
//               child: DrawerHeader(
//                 decoration: BoxDecoration(color: Colors.redAccent),
//                 child: Padding(
//                   padding: EdgeInsets.all(3.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.only(bottom: 10.0),
//                         width: 60.0,
//                         height: 60.0,
//                         child: CircleAvatar(
//                           backgroundImage:
//                               AssetImage('assets/img/iconfreshbox.png'),
//                           backgroundColor: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 3.0,
//                       ),
//                       Text(
//                         name,
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 3.0,
//                       ),
//                       Text(
//                         nik,
//                         style: TextStyle(fontSize: 14.0, color: Colors.white),
//                       ),
//                       Text(
//                         role,
//                         style: TextStyle(fontSize: 14.0, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: role == "Pickers"
//                   ? ListView(
//                       padding: EdgeInsets.zero,
//                       children: <Widget>[
//                         ListTile(
//                           leading: Icon(Icons.home),
//                           title: Text("Home"),
//                           onTap: () => onTap(context, 0),
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.arrow_forward),
//                           title: Text('Hold'),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Text('B2C: '),
//                               Chip(
//                                 label: Text(
//                                   holdPick.toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 13.0,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 backgroundColor: Colors.grey[600],
//                               ),
//                               SizedBox(
//                                 width: 3.0,
//                               ),
//                               Text('B2B: '),
//                               Chip(
//                                 label: Text(
//                                   holdPickb2b.toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 13.0,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 backgroundColor: Colors.grey[600],
//                               ),
//                             ],
//                           ),
//                           onTap: () => onTap(context, 1),
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.access_time),
//                           title: Text('Pending'),
//                           trailing: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Text('B2C: '),
//                               Chip(
//                                 label: Text(
//                                   pendingPick.toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 13.0,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 backgroundColor: Colors.orange[600],
//                               ),
//                               SizedBox(
//                                 width: 3.0,
//                               ),
//                               Text('B2B: '),
//                               Chip(
//                                 label: Text(
//                                   pendingPickb2b.toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 13.0,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 backgroundColor: Colors.orange[600],
//                               ),
//                             ],
//                           ),
//                           onTap: () => onTap(context, 2),
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.format_list_bulleted),
//                           title: Text('Attendance'),
//                           onTap: () => onTap(context, 3),
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.lock_outline),
//                           title: Text('Change password'),
//                           onTap: () {
//                             Navigator.of(context).pushReplacement(
//                                 PageRouteBuilder(
//                                     pageBuilder: (_, __, ___) =>
//                                         ChangePasswordPage(),
//                                     transitionDuration:
//                                         Duration(milliseconds: 750),

//                                     /// Set animation with opacity
//                                     transitionsBuilder: (_,
//                                         Animation<double> animation,
//                                         __,
//                                         Widget child) {
//                                       return Opacity(
//                                         opacity: animation.value,
//                                         child: child,
//                                       );
//                                     }));
//                           },
//                         ),
//                         ListTile(
//                           leading: Icon(Icons.exit_to_app),
//                           title: Text("Logout"),
//                           onTap: () => logout(),
//                         ),
//                       ],
//                     )
//                   : role == "QC B2C" || role == "QC B2B"
//                       ? ListView(
//                           padding: EdgeInsets.zero,
//                           children: <Widget>[
//                             ListTile(
//                               leading: Icon(Icons.home),
//                               title: Text("Home"),
//                               onTap: () => onTap(context, 0),
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.arrow_forward),
//                               title: Text('Hold'),
//                               trailing: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   Text('B2C: '),
//                                   Chip(
//                                     label: Text(
//                                       holdQc.toString(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 13.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     backgroundColor: Colors.grey[600],
//                                   ),
//                                   SizedBox(
//                                     width: 3.0,
//                                   ),
//                                   Text('B2B: '),
//                                   Chip(
//                                     label: Text(
//                                       holdQcb2b.toString(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 13.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     backgroundColor: Colors.grey[600],
//                                   ),
//                                 ],
//                               ),
//                               onTap: () => onTap(context, 1),
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.access_time),
//                               title: Text('Pending Pick'),
//                               trailing: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   Text('B2C: '),
//                                   Chip(
//                                     label: Text(
//                                       pendingQc.toString(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 13.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     backgroundColor: Colors.orange[600],
//                                   ),
//                                   SizedBox(
//                                     width: 3.0,
//                                   ),
//                                   Text('B2B: '),
//                                   Chip(
//                                     label: Text(
//                                       pendingQcb2b.toString(),
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 13.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     backgroundColor: Colors.orange[600],
//                                   ),
//                                 ],
//                               ),
//                               onTap: () => onTap(context, 2),
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.format_list_bulleted),
//                               title: Text('Attendance'),
//                               onTap: () => onTap(context, 3),
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.lock_outline),
//                               title: Text('Change password'),
//                               onTap: () {
//                                 Navigator.of(context).pushReplacement(
//                                     PageRouteBuilder(
//                                         pageBuilder: (_, __, ___) =>
//                                             ChangePasswordPage(),
//                                         transitionDuration:
//                                             Duration(milliseconds: 750),

//                                         /// Set animation with opacity
//                                         transitionsBuilder: (_,
//                                             Animation<double> animation,
//                                             __,
//                                             Widget child) {
//                                           return Opacity(
//                                             opacity: animation.value,
//                                             child: child,
//                                           );
//                                         }));
//                               },
//                             ),
//                             ListTile(
//                               leading: Icon(Icons.exit_to_app),
//                               title: Text("Logout"),
//                               onTap: () => logout(),
//                             ),
//                           ],
//                         )
//                       : role == "Purchasing"
//                           ? ListView(
//                               padding: EdgeInsets.zero,
//                               children: <Widget>[
//                                 ListTile(
//                                   leading: Icon(Icons.home),
//                                   title: Text('Home'),
//                                   // trailing: Chip(
//                                   //   label: Text(
//                                   //     '0',
//                                   //     textAlign: TextAlign.center,
//                                   //     style: TextStyle(
//                                   //         color: Colors.white,
//                                   //         fontSize: 13.0,
//                                   //         fontWeight: FontWeight.bold),
//                                   //   ),
//                                   //   backgroundColor: Colors.redAccent,
//                                   // ),
//                                   onTap: () => onTap(context, 0),
//                                 ),
//                                 ListTile(
//                                   leading: Icon(Icons.archive),
//                                   title: Text('Procurement'),
//                                   // trailing: Row(
//                                   //   mainAxisSize: MainAxisSize.min,
//                                   //   children: <Widget>[
//                                   //     Chip(
//                                   //       label: Text(
//                                   //         '0',
//                                   //         textAlign: TextAlign.center,
//                                   //         style: TextStyle(
//                                   //             color: Colors.white,
//                                   //             fontSize: 13.0,
//                                   //             fontWeight: FontWeight.bold),
//                                   //       ),
//                                   //       backgroundColor: Colors.black54,
//                                   //     ),
//                                   //   ],
//                                   // ),
//                                   onTap: () => onTap(context, 1),
//                                 ),
//                                 ListTile(
//                                   leading: Icon(Icons.history),
//                                   title: Text('History'),
//                                   onTap: () => onTap(context, 2),
//                                 ),
//                                 ListTile(
//                                   leading: Icon(Icons.format_list_bulleted),
//                                   title: Text('Attendance'),
//                                   onTap: () => onTap(context, 3),
//                                 ),
//                                 ListTile(
//                                   leading: Icon(Icons.lock_outline),
//                                   title: Text('Change password'),
//                                   onTap: () {
//                                     Navigator.of(context).pushReplacement(
//                                         PageRouteBuilder(
//                                             pageBuilder: (_, __, ___) =>
//                                                 ChangePasswordPage(),
//                                             transitionDuration:
//                                                 Duration(milliseconds: 750),

//                                             /// Set animation with opacity
//                                             transitionsBuilder: (_,
//                                                 Animation<double> animation,
//                                                 __,
//                                                 Widget child) {
//                                               return Opacity(
//                                                 opacity: animation.value,
//                                                 child: child,
//                                               );
//                                             }));
//                                   },
//                                 ),
//                                 ListTile(
//                                   leading: Icon(Icons.exit_to_app),
//                                   title: Text("Logout"),
//                                   onTap: () => logout(),
//                                 ),
//                               ],
//                             )
//                           : role == "Receiving Staff"
//                               ? ListView(
//                                   padding: EdgeInsets.zero,
//                                   children: <Widget>[
//                                     ListTile(
//                                       leading: Icon(Icons.file_upload),
//                                       title: Text('Receiving'),
//                                       onTap: () => onTap(context, 0),
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.file_download),
//                                       title: Text('Confirm Receiving'),
//                                       onTap: () => onTap(context, 1),
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.format_list_bulleted),
//                                       title: Text('Attendance'),
//                                       onTap: () => onTap(context, 2),
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.lock_outline),
//                                       title: Text('Change password'),
//                                       onTap: () {
//                                         Navigator.of(context).pushReplacement(
//                                             PageRouteBuilder(
//                                                 pageBuilder: (_, __, ___) =>
//                                                     ChangePasswordPage(),
//                                                 transitionDuration:
//                                                     Duration(milliseconds: 750),

//                                                 /// Set animation with opacity
//                                                 transitionsBuilder: (_,
//                                                     Animation<double> animation,
//                                                     __,
//                                                     Widget child) {
//                                                   return Opacity(
//                                                     opacity: animation.value,
//                                                     child: child,
//                                                   );
//                                                 }));
//                                       },
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.exit_to_app),
//                                       title: Text("Logout"),
//                                       onTap: () => logout(),
//                                     ),
//                                   ],
//                                 )
//                               : ListView(
//                                   padding: EdgeInsets.zero,
//                                   children: <Widget>[
//                                     ListTile(
//                                       leading: Icon(Icons.format_list_bulleted),
//                                       title: Text('Attendance'),
//                                       onTap: () => onTap(context, 0),
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.lock_outline),
//                                       title: Text('Change password'),
//                                       onTap: () {
//                                         Navigator.of(context).pushReplacement(
//                                             PageRouteBuilder(
//                                                 pageBuilder: (_, __, ___) =>
//                                                     ChangePasswordPage(),
//                                                 transitionDuration:
//                                                     Duration(milliseconds: 750),

//                                                 /// Set animation with opacity
//                                                 transitionsBuilder: (_,
//                                                     Animation<double> animation,
//                                                     __,
//                                                     Widget child) {
//                                                   return Opacity(
//                                                     opacity: animation.value,
//                                                     child: child,
//                                                   );
//                                                 }));
//                                       },
//                                     ),
//                                     ListTile(
//                                       leading: Icon(Icons.exit_to_app),
//                                       title: Text("Logout"),
//                                       onTap: () => logout(),
//                                     ),
//                                   ],
//                                 ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
