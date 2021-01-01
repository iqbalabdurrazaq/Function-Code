// import 'dart:convert';
// import 'package:appsfreshbox/Services/Services.dart';
// import 'package:appsfreshbox/SideBarPage.dart';
// import 'package:appsfreshbox/models/Datajson.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class DetailConfirmReceivingPageCopy2 extends StatefulWidget {
//   final int menu;
//   DetailConfirmReceivingPageCopy2({this.menu});
//   @override
//   _DetailConfirmReceivingPageCopy2State createState() =>
//       _DetailConfirmReceivingPageCopy2State();
// }

// class _DetailConfirmReceivingPageCopy2State
//     extends State<DetailConfirmReceivingPageCopy2> {
//   @override
//   void initState() {
//     if (mounted) {
//       _getDetItemProcForReceiving();
//     }
//     super.initState();
//     _autoValidate = false;
//     isSubmit = false;
//     isLoading = false;
//     isPost = false;
//     listItemProcReceive = new List();
//     tmplistItemProcReceive = new List();
//     listProc = new List();
//     listItemReceive = new List();
//     tmplistItemReceive = new List();
//     tmpReceiving = new List();
//     _formKey = new GlobalKey<FormState>();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   List<ItemProc> listProc;

//   List<Map<String, dynamic>> listItemProcReceive;
//   List<Map<String, dynamic>> tmplistItemProcReceive;

//   List<TmpReceiving> listItemReceive;
//   List<TmpReceiving> tmplistItemReceive;

//   List<Receiving> tmpReceiving;

//   TextEditingController filterController = TextEditingController();
//   TextEditingController bruttoEditingController = TextEditingController();
//   TextEditingController nettoEditingController = TextEditingController();
//   TextEditingController rejectEditingController = TextEditingController();
//   GlobalKey<FormState> _formKey;
//   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   bool _autoValidate, tmpMsg, isSubmit, isLoading, isPost;
//   final convertMoney = NumberFormat("#,##0", "en_US");
//   int selectedUom;
//   final formatDateTime = new DateFormat('yyyy-MM-dd HH:mm');

//   int getColorHexFromStr(String color) {
//     color = "FF" + color;
//     color = color.replaceAll("#", "");
//     int val = 0;
//     int len = color.length;
//     for (var i = 0; i < len; i++) {
//       int hexDgt = color.codeUnitAt(i);
//       if (hexDgt >= 48 && hexDgt <= 57) {
//         val += (hexDgt - 48) * (1 << (4 * (len - 1 - i)));
//       } else if (hexDgt >= 65 && hexDgt <= 70) {
//         val += (hexDgt - 55) * (1 << (4 * (len - 1 - i)));
//       } else if (hexDgt >= 97 && hexDgt <= 102) {
//         val += (hexDgt - 87) * (1 << (4 * (len - 1 - i)));
//       } else {
//         throw new FormatException("Error converting color");
//       }
//     }
//     return val;
//   }

//   _getDetItemProcForReceiving() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     if (!mounted) return;
//     setState(() {
//       final getItem = jsonDecode(localStorage.getString('tmpListItemProc'))
//           .cast<Map<String, dynamic>>();
//       listProc =
//           getItem.map<ItemProc>((json) => ItemProc.fromJson(json)).toList();
//     });
//     listProc.forEach((element) async {
//       http.Response response = await Services()
//           .getDetItemProcForReceiving(element.itemidgroup.toString());
//       if (response.statusCode == 200) {
//         if (!mounted) return;
//         setState(() {
//           final prefix = 'ï»¿';
//           var body = response.body;
//           if (body.startsWith(prefix)) {
//             body = body.substring(prefix.length);
//           }
//           final result = jsonDecode(body)['data'].cast<Map<String, dynamic>>();
//           listItemProcReceive = result;
//           Map<String, dynamic> data = {
//             'item_name_group': element.itemnamegroup,
//             'item_id_group': element.itemidgroup,
//             'uom_group_name': element.uomgroupname,
//             'receive_brutto': element.receivebrutto,
//             'receive_netto': element.receivenetto,
//             'receive_reject': element.receivereject,
//             'data': listItemProcReceive,
//           };

//           tmplistItemProcReceive.add(data);

//           listItemReceive = tmplistItemProcReceive
//               .map<TmpReceiving>((json) => TmpReceiving.fromJson(json))
//               .toList();

//           // print(tmplistItemProcReceive);
//           // print("data: ${tmplistItemProcReceive.length}");
//           isLoading = true;
//         });
//       } else if (response.statusCode == 404) {
//         if (!mounted) return;
//         setState(() {
//           tmpMsg = false;
//           final snackBar = SnackBar(
//             content: Text("Data ${element.itemnamegroup} Tidak Ada"),
//             action: SnackBarAction(
//               label: 'Back',
//               textColor: Colors.white,
//               onPressed: () => Navigator.pushReplacement(
//                 context,
//                 new MaterialPageRoute(
//                     builder: (context) => SideBarPage(selectPage: widget.menu)),
//               ),
//             ),
//             duration: new Duration(seconds: 5),
//             backgroundColor: Colors.red,
//           );
//           _scaffoldKey.currentState.showSnackBar(snackBar);
//         });
//       } else {
//         setState(() {
//           final snackBar = SnackBar(
//             content: Text("Koneksi Terputus,"),
//             action: SnackBarAction(
//               label: 'Coba Lagi',
//               textColor: Colors.white,
//               onPressed: () => Navigator.pushReplacement(
//                 context,
//                 new MaterialPageRoute(
//                     builder: (context) => DetailConfirmReceivingPageCopy2(
//                           menu: widget.menu,
//                         )),
//               ),
//             ),
//             duration: new Duration(seconds: 10),
//             backgroundColor: Colors.red,
//           );
//           _scaffoldKey.currentState.showSnackBar(snackBar);
//         });
//       }
//     });
//   }

//   _posItemProcConfirmReceive() async {
//     setState(() {
//       isSubmit = true;
//     });

//     // int nettoBesar = 0;
//     int rejectBesar = 0;

//     listItemReceive.forEach((element) {
//       if (double.parse(element.receivingreject) >
//           double.parse(element.receivingnetto)) {
//         rejectBesar += 1;
//       }
//     });

//     var data = {
//       'items': listItemReceive,
//     };

//     if (rejectBesar > 0) {
//       _showDialog("Maaf, Reject Terlalu Besar Dibandingkan Netto");
//     } else {
//       setState(() {
//         isPost = true;
//       });
//       var response = await Services().posItemProcConfirmReceive(data);
//       if (response.statusCode == 200) {
//         WidgetsBinding.instance.addPostFrameCallback((_) async {
//           await showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => new AlertDialog(
//               title: new Text("Confirm Procurement"),
//               content: new Text("Berhasil..."),
//               actions: <Widget>[
//                 new FlatButton(
//                   child: new Text("Ok"),
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(PageRouteBuilder(
//                         pageBuilder: (_, __, ___) => SideBarPage(
//                               selectPage: widget.menu,
//                             ),
//                         transitionDuration: Duration(milliseconds: 750),

//                         /// Set animation with opacity
//                         transitionsBuilder:
//                             (_, Animation<double> animation, __, Widget child) {
//                           return Opacity(
//                             opacity: animation.value,
//                             child: child,
//                           );
//                         }));
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//       } else {
//         WidgetsBinding.instance.addPostFrameCallback((_) async {
//           await showDialog<String>(
//             context: context,
//             builder: (BuildContext context) => new AlertDialog(
//               title: new Text("Pemberitahuan"),
//               content: new Text("Confirm Gagal..."),
//               actions: <Widget>[
//                 new FlatButton(
//                   child: new Text("Ok"),
//                   onPressed: () {
//                     Navigator.of(context).pushReplacement(PageRouteBuilder(
//                         pageBuilder: (_, __, ___) =>
//                             DetailConfirmReceivingPageCopy2(
//                               menu: widget.menu,
//                             ),
//                         transitionDuration: Duration(milliseconds: 750),

//                         /// Set animation with opacity
//                         transitionsBuilder:
//                             (_, Animation<double> animation, __, Widget child) {
//                           return Opacity(
//                             opacity: animation.value,
//                             child: child,
//                           );
//                         }));
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//       }
//     }
//     setState(() {
//       isSubmit = false;
//     });
//   }

//   _showDialog(msg) {
//     final snackBar = SnackBar(
//       content: Text(msg),
//       duration: new Duration(seconds: 1),
//       backgroundColor: Colors.red,
//     );
//     _scaffoldKey.currentState.showSnackBar(snackBar);
//   }

//   onFilterChanged(String text) async {
//     List<TmpReceiving> tmp1;
//     List<Map<String, dynamic>> tmp2 = new List();
//     List<Map<String, dynamic>> tmp3 = new List();

//     tmplistItemReceive.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     listItemReceive.forEach((element1) {
//       // if (element1.data[0].itemGroupProc.namegroup
//       if (element1.itemnamegroup.toLowerCase().contains(text)) {
//         tmplistItemReceive.add(element1);
//       }
//     });

//     setState(() {});
//   }

//   _backBtn() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     localStorage.remove('tmpListItemProc');
//     Navigator.of(context).pushReplacement(PageRouteBuilder(
//         pageBuilder: (_, __, ___) => SideBarPage(
//               selectPage: 0,
//             ),
//         transitionDuration: Duration(milliseconds: 750),

//         /// Set animation with opacity
//         transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//           return Opacity(
//             opacity: animation.value,
//             child: child,
//           );
//         }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _backBtn(),
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text('Detail Confirm Item Receive'),
//           backgroundColor: Colors.red,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => _backBtn(),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Container(
//               color: Color(getColorHexFromStr("#fff5ea")),
//             ),
//             Column(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
//                   child: Material(
//                     borderRadius: BorderRadius.circular(7.0),
//                     child: TextFormField(
//                       controller: filterController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(7.0),
//                         ),
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.black,
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.cancel),
//                           onPressed: () {
//                             filterController.clear();
//                             onFilterChanged('');
//                           },
//                         ),
//                         contentPadding: EdgeInsets.only(left: 10.0, top: 15.0),
//                         hintText: "Search Item Name",
//                         hintStyle: TextStyle(color: Colors.grey),
//                       ),
//                       onFieldSubmitted: onFilterChanged,
//                       onTap: () {
//                         filterController.clear();
//                         onFilterChanged('');
//                       },
//                     ),
//                   ),
//                 ),
//                 Form(
//                   key: _formKey,
//                   autovalidate: _autoValidate,
//                   child: Flexible(
//                     flex: 1,
//                     child: isLoading
//                         ? tmplistItemReceive.length > 0 ||
//                                 filterController.text.isNotEmpty
//                             ? ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: AlwaysScrollableScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: tmplistItemReceive.length,
//                                 itemBuilder: (context, index1) {
//                                   return Column(
//                                     children: [
//                                       ExpansionTile(
//                                         title: Text(
//                                           '${tmplistItemReceive[index1].itemnamegroup}',
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         // : Text(''),
//                                         children: tmplistItemReceive[index1]
//                                             .data
//                                             .map((e) {
//                                           return ListTile(
//                                             title: Text(
//                                               'Procurement: ${e.trxProcurement2.userProc.user.name}',
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             subtitle: Column(
//                                               children: [
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       'Uom Procurement: ${e.uomProc.name}',
//                                                       style: TextStyle(
//                                                           fontSize: 14.0,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     ),
//                                                     Text(
//                                                       'Tanggal: ${formatDateTime.format(DateTime.parse(e.createdat))}',
//                                                       style: TextStyle(
//                                                           fontSize: 14.0,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 RaisedButton(
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       tmplistItemReceive[index1]
//                                                           .data
//                                                           .removeWhere((element) =>
//                                                               element
//                                                                   .idtrxprocurement ==
//                                                               e.idtrxprocurement);
//                                                       if (tmplistItemReceive[
//                                                                   index1]
//                                                               .data
//                                                               .length ==
//                                                           0) {
//                                                         listItemReceive.removeWhere(
//                                                             (element) =>
//                                                                 element
//                                                                     .itemnamegroup ==
//                                                                 tmplistItemReceive[
//                                                                         index1]
//                                                                     .itemnamegroup);
//                                                         tmplistItemReceive
//                                                             .removeAt(index1);
//                                                         print(
//                                                             index1.toString());
//                                                       }
//                                                     });
//                                                   },
//                                                   color: Colors.grey,
//                                                   child: Text(
//                                                     'Cancel',
//                                                     style: TextStyle(
//                                                         color: Colors.white),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                       tmplistItemReceive[index1].data.length > 0
//                                           ? Padding(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 20.0,
//                                                       vertical: 10.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Expanded(
//                                                     child: Column(
//                                                       children: [
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                             'Brutto: ',
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 10.0,
//                                                         ),
//                                                         TextFormField(
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           keyboardType:
//                                                               TextInputType
//                                                                   .number,
//                                                           decoration:
//                                                               InputDecoration(
//                                                             border:
//                                                                 OutlineInputBorder(),
//                                                             hintText: 'Brutto',
//                                                           ),
//                                                           initialValue:
//                                                               tmplistItemReceive[
//                                                                           index1]
//                                                                       .receivingbrutto
//                                                                       .toString() ??
//                                                                   null,
//                                                           onChanged: (value) {
//                                                             if (value == null ||
//                                                                 value == '') {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                         index1]
//                                                                     .receivingbrutto = "0";
//                                                               });
//                                                             } else {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingbrutto =
//                                                                     value.replaceAll(
//                                                                         ",",
//                                                                         ".");
//                                                                 print("brutto" +
//                                                                     tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingbrutto);
//                                                               });
//                                                             }
//                                                           },
//                                                           validator: (value) {
//                                                             if (value.isEmpty) {
//                                                               return "Please, isi text";
//                                                             } else {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingbrutto =
//                                                                     value.replaceAll(
//                                                                         ",",
//                                                                         ".");
//                                                               });
//                                                               return null;
//                                                             }
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5.0,
//                                                   ),
//                                                   Expanded(
//                                                     child: Column(
//                                                       children: [
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                             'Netto: ',
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 10.0,
//                                                         ),
//                                                         TextFormField(
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           keyboardType:
//                                                               TextInputType
//                                                                   .number,
//                                                           decoration:
//                                                               InputDecoration(
//                                                             border:
//                                                                 OutlineInputBorder(),
//                                                             hintText: 'Netto',
//                                                           ),
//                                                           initialValue:
//                                                               tmplistItemReceive[
//                                                                           index1]
//                                                                       .receivingnetto
//                                                                       .toString() ??
//                                                                   null,
//                                                           onChanged: (value) {
//                                                             if (value == null ||
//                                                                 value == '') {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                         index1]
//                                                                     .receivingnetto = "0";
//                                                               });
//                                                             } else {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingnetto =
//                                                                     value.replaceAll(
//                                                                         ",",
//                                                                         ".");
//                                                               });
//                                                             }
//                                                           },
//                                                           validator: (value) {
//                                                             if (value.isEmpty) {
//                                                               return "Please, isi text";
//                                                             } else {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingnetto =
//                                                                     value.replaceAll(
//                                                                         ",",
//                                                                         ".");
//                                                               });
//                                                               return null;
//                                                             }
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5.0,
//                                                   ),
//                                                   Expanded(
//                                                     child: Column(
//                                                       children: [
//                                                         Align(
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           child: Text(
//                                                             'Reject: ',
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                           ),
//                                                         ),
//                                                         SizedBox(
//                                                           height: 10.0,
//                                                         ),
//                                                         TextFormField(
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           keyboardType:
//                                                               TextInputType
//                                                                   .number,
//                                                           decoration:
//                                                               InputDecoration(
//                                                             border:
//                                                                 OutlineInputBorder(),
//                                                             hintText: 'Reject',
//                                                           ),
//                                                           initialValue:
//                                                               tmplistItemReceive[
//                                                                           index1]
//                                                                       .receivingreject
//                                                                       .toString() ??
//                                                                   null,
//                                                           onChanged: (value) {
//                                                             if (value == null ||
//                                                                 value == '') {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                         index1]
//                                                                     .receivingreject = "0";
//                                                               });
//                                                             } else {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingreject =
//                                                                     value.replaceAll(
//                                                                         ",",
//                                                                         ".");
//                                                               });
//                                                             }
//                                                           },
//                                                           validator: (value) {
//                                                             if (value.isEmpty) {
//                                                               return "Please, isi text";
//                                                             } else {
//                                                               setState(() {
//                                                                 tmplistItemReceive[
//                                                                             index1]
//                                                                         .receivingreject =
//                                                                     value.replaceAll(
//                                                                         ",",
//                                                                         ".");
//                                                               });

//                                                               return null;
//                                                             }
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5.0,
//                                                   ),
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Align(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         child: Text(
//                                                           'Uom: ${tmplistItemReceive[index1].uomgroupname}',
//                                                           style: TextStyle(
//                                                               fontSize: 14.0,
//                                                               color:
//                                                                   Colors.black),
//                                                         )),
//                                                   ),
//                                                   // : Text('')
//                                                 ],
//                                               ),
//                                             )
//                                           : Text(''),
//                                       Container(
//                                         height: 2.0,
//                                         width: double.infinity,
//                                         color: Colors.black,
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               )
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: AlwaysScrollableScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 itemCount: listItemReceive.length,
//                                 itemBuilder: (context, index1) {
//                                   return Container(
//                                     child: Column(
//                                       children: [
//                                         ExpansionTile(
//                                           title: Text(
//                                             '${listItemReceive[index1].itemnamegroup}',
//                                             style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           // : Text(''),
//                                           children: listItemReceive[index1]
//                                               .data
//                                               .map((e) {
//                                             return ListTile(
//                                               title: Text(
//                                                 'Procurement: ${e.trxProcurement2.userProc.user.name}',
//                                                 style: TextStyle(
//                                                     fontSize: 16.0,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               subtitle: Column(
//                                                 children: [
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         'Uom Procurement: ${e.uomProc.name}',
//                                                         style: TextStyle(
//                                                             fontSize: 14.0,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w500),
//                                                       ),
//                                                       Text(
//                                                         'Tanggal: ${formatDateTime.format(DateTime.parse(e.createdat))}',
//                                                         style: TextStyle(
//                                                             fontSize: 14.0,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w500),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   RaisedButton(
//                                                     onPressed: () {
//                                                       setState(() {
//                                                         listItemReceive[index1]
//                                                             .data
//                                                             .removeWhere((element) =>
//                                                                 element
//                                                                     .idtrxprocurement ==
//                                                                 e.idtrxprocurement);
//                                                         if (listItemReceive[
//                                                                     index1]
//                                                                 .data
//                                                                 .length ==
//                                                             0) {
//                                                           print(index1);
//                                                           listItemReceive
//                                                               .removeAt(index1);
//                                                         }
//                                                       });
//                                                     },
//                                                     color: Colors.grey,
//                                                     child: Text(
//                                                       'Cancel',
//                                                       style: TextStyle(
//                                                           color: Colors.white),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           }).toList(),
//                                         ),
//                                         listItemReceive[index1].data.length > 0
//                                             ? Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 20.0,
//                                                         vertical: 10.0),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                   children: [
//                                                     Expanded(
//                                                       child: Column(
//                                                         children: [
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               'Brutto: ',
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 10.0,
//                                                           ),
//                                                           TextFormField(
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             decoration:
//                                                                 InputDecoration(
//                                                               border:
//                                                                   OutlineInputBorder(),
//                                                               hintText:
//                                                                   'Brutto',
//                                                             ),
//                                                             initialValue: listItemReceive[
//                                                                         index1]
//                                                                     .receivingbrutto
//                                                                     .toString() ??
//                                                                 null,
//                                                             onChanged: (value) {
//                                                               if (value ==
//                                                                       null ||
//                                                                   value == '') {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                           index1]
//                                                                       .receivingbrutto = "0";
//                                                                 });
//                                                               } else {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                               index1]
//                                                                           .receivingbrutto =
//                                                                       value.replaceAll(
//                                                                           ",",
//                                                                           ".");
//                                                                   print("brutto" +
//                                                                       listItemReceive[
//                                                                               index1]
//                                                                           .receivingbrutto);
//                                                                 });
//                                                               }
//                                                             },
//                                                             validator: (value) {
//                                                               if (value
//                                                                   .isEmpty) {
//                                                                 return "Please, isi text";
//                                                               } else {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                               index1]
//                                                                           .receivingbrutto =
//                                                                       value.replaceAll(
//                                                                           ",",
//                                                                           ".");
//                                                                 });
//                                                                 return null;
//                                                               }
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5.0,
//                                                     ),
//                                                     Expanded(
//                                                       child: Column(
//                                                         children: [
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               'Netto: ',
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 10.0,
//                                                           ),
//                                                           TextFormField(
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             decoration:
//                                                                 InputDecoration(
//                                                               border:
//                                                                   OutlineInputBorder(),
//                                                               hintText: 'Netto',
//                                                             ),
//                                                             initialValue: listItemReceive[
//                                                                         index1]
//                                                                     .receivingnetto
//                                                                     .toString() ??
//                                                                 null,
//                                                             onChanged: (value) {
//                                                               if (value ==
//                                                                       null ||
//                                                                   value == '') {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                           index1]
//                                                                       .receivingnetto = "0";
//                                                                 });
//                                                               } else {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                               index1]
//                                                                           .receivingnetto =
//                                                                       value.replaceAll(
//                                                                           ",",
//                                                                           ".");
//                                                                 });
//                                                               }
//                                                             },
//                                                             validator: (value) {
//                                                               if (value
//                                                                   .isEmpty) {
//                                                                 return "Please, isi text";
//                                                               } else {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                               index1]
//                                                                           .receivingnetto =
//                                                                       value.replaceAll(
//                                                                           ",",
//                                                                           ".");
//                                                                 });
//                                                                 return null;
//                                                               }
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5.0,
//                                                     ),
//                                                     Expanded(
//                                                       child: Column(
//                                                         children: [
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Text(
//                                                               'Reject: ',
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             height: 10.0,
//                                                           ),
//                                                           TextFormField(
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             decoration:
//                                                                 InputDecoration(
//                                                               border:
//                                                                   OutlineInputBorder(),
//                                                               hintText:
//                                                                   'Reject',
//                                                             ),
//                                                             initialValue: listItemReceive[
//                                                                         index1]
//                                                                     .receivingreject
//                                                                     .toString() ??
//                                                                 null,
//                                                             onChanged: (value) {
//                                                               if (value ==
//                                                                       null ||
//                                                                   value == '') {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                           index1]
//                                                                       .receivingreject = "0";
//                                                                 });
//                                                               } else {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                               index1]
//                                                                           .receivingreject =
//                                                                       value.replaceAll(
//                                                                           ",",
//                                                                           ".");
//                                                                 });
//                                                               }
//                                                             },
//                                                             validator: (value) {
//                                                               if (value
//                                                                   .isEmpty) {
//                                                                 return "Please, isi text";
//                                                               } else {
//                                                                 setState(() {
//                                                                   listItemReceive[
//                                                                               index1]
//                                                                           .receivingreject =
//                                                                       value.replaceAll(
//                                                                           ",",
//                                                                           ".");
//                                                                 });

//                                                                 return null;
//                                                               }
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 5.0,
//                                                     ),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       child: Align(
//                                                           alignment:
//                                                               Alignment.center,
//                                                           child: Text(
//                                                             'Uom: ${listItemReceive[index1].uomgroupname}',
//                                                             style: TextStyle(
//                                                                 fontSize: 14.0,
//                                                                 color: Colors
//                                                                     .black),
//                                                           )),
//                                                     ),
//                                                     // : Text('')
//                                                   ],
//                                                 ),
//                                               )
//                                             : Text(''),
//                                         Container(
//                                           height: 2.0,
//                                           width: double.infinity,
//                                           color: Colors.black,
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               )
//                         : Center(
//                             child: tmpMsg == false
//                                 ? ListView(
//                                     shrinkWrap: true,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 20.0, vertical: 10.0),
//                                     scrollDirection: Axis.vertical,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     children: <Widget>[
//                                       Container(
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.15,
//                                         child: Card(
//                                           elevation: 1.0,
//                                           margin: EdgeInsets.all(10.0),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15.0),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'Data Tidak Tersedia',
//                                               style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 22.0),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                                 : CircularProgressIndicator(),
//                           ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     // mainAxisSize: MainAxisSize.min,
//                     children: [
//                       RaisedButton(
//                         onPressed: () {
//                           if (!isPost) {
//                             if (listItemReceive.length > 0) {
//                               if (_formKey.currentState.validate()) {
//                                 _posItemProcConfirmReceive();
//                               } else {
//                                 setState(() {
//                                   _autoValidate = true;
//                                 });
//                               }
//                             }
//                           }
//                         },
//                         color: Colors.green,
//                         child: Text(
//                           isSubmit ? 'Processing' : 'Receive',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
