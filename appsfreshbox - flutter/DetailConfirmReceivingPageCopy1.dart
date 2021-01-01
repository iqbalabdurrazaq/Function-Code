// import 'dart:convert';
// import 'package:appsfreshbox/Services/Services.dart';
// import 'package:appsfreshbox/SideBarPage.dart';
// import 'package:appsfreshbox/models/Datajson.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DetailConfirmReceivingPage extends StatefulWidget {
//   final int menu, idproc;
//   final String noproc;
//   DetailConfirmReceivingPage({this.menu, this.idproc, this.noproc});
//   @override
//   _DetailConfirmReceivingPageState createState() =>
//       _DetailConfirmReceivingPageState();
// }

// class _DetailConfirmReceivingPageState
//     extends State<DetailConfirmReceivingPage> {
//   @override
//   void initState() {
//     super.initState();
//     _autoValidate = false;
//     isSubmit = false;
//     isLoading = false;
//     if (mounted) {
//       _postNoProcReceiveDet();
//       _getDataUom();
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Procurement dataProc;
//   List<ItemProc> listProc = [];
//   List<Uom> listUom = [];
//   List<ItemProc> filterProc = [];
//   TextEditingController filterController = TextEditingController();
//   GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   bool _autoValidate, tmpMsg, isSubmit, isLoading;
//   final convertMoney = NumberFormat("#,##0", "en_US");
//   int selectedUom;

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

//   _postNoProcReceiveDet() async {
//     var response = await Services().postNoProcReceiveDet(widget.noproc);
//     if (response.statusCode == 200) {
//       if (!mounted) return;
//       setState(() {
//         final result = jsonDecode(response.body)['data'][0];
//         dataProc = Procurement.fromJson(result);
//         listProc = dataProc.itemProc;
//         isLoading = true;
//         print(dataProc);
//       });
//     } else if (response.statusCode == 401) {
//       if (!mounted) return;
//       setState(() {
//         tmpMsg = false;
//         final snackBar = SnackBar(
//           content: Text("Data Tidak Ada"),
//           action: SnackBarAction(
//             label: 'Back',
//             textColor: Colors.white,
//             onPressed: () => Navigator.pushReplacement(
//               context,
//               new MaterialPageRoute(
//                   builder: (context) => SideBarPage(selectPage: widget.menu)),
//             ),
//           ),
//           duration: new Duration(minutes: 30),
//           backgroundColor: Colors.red,
//         );
//         _scaffoldKey.currentState.showSnackBar(snackBar);
//       });
//     } else {
//       setState(() {
//         final snackBar = SnackBar(
//           content: Text("Koneksi Terputus,"),
//           action: SnackBarAction(
//             label: 'Coba Lagi',
//             textColor: Colors.white,
//             onPressed: () => Navigator.pushReplacement(
//               context,
//               new MaterialPageRoute(
//                   builder: (context) => DetailConfirmReceivingPage(
//                         noproc: widget.noproc,
//                         menu: widget.menu,
//                       )),
//             ),
//           ),
//           duration: new Duration(seconds: 10),
//           backgroundColor: Colors.red,
//         );
//         _scaffoldKey.currentState.showSnackBar(snackBar);
//       });
//     }
//   }

//   _getDataUom() async {
//     var response = await Services().getDataUom();
//     if (response.statusCode == 200) {
//       if (!mounted) return;
//       setState(() {
//         final result =
//             json.decode(response.body)['data'].cast<Map<String, dynamic>>();
//         listUom = result.map<Uom>((json) => Uom.fromJson(json)).toList();
//         selectedUom = listUom[0].id;
//         // print(listUom.length);
//       });
//     }
//   }

//   _postConfirmReceiveProc() async {
//     setState(() {
//       isSubmit = true;
//     });
//     var data = {
//       "id": dataProc.id.toString(),
//       "items": listProc,
//     };
//     int emptyUom = 0;
//     int nettoBesar = 0;
//     int rejectBesar = 0;
//     listProc.forEach((element) {
//       if (element.uomgroupid == null) {
//         emptyUom += 1;
//       }
//       if (double.parse(element.receivenetto) >
//           double.parse(element.receivebrutto)) {
//         nettoBesar += 1;
//       } else if (double.parse(element.receivereject) >
//           double.parse(element.receivenetto)) {
//         rejectBesar += 1;
//       }
//     });
//     if (emptyUom > 0) {
//       _showDialog("Please, isi uom");
//     } else if (nettoBesar > 0) {
//       _showDialog("Maaf, Netto Terlalu Besar Dibandingkan Brutto");
//     } else if (rejectBesar > 0) {
//       _showDialog("Maaf, Reject Terlalu Besar Dibandingkan Netto");
//     } else {
//       var response = await Services().postConfirmReceiveProc(data);
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
//       } else if (response.statusCode == 401) {
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
//                         pageBuilder: (_, __, ___) => DetailConfirmReceivingPage(
//                               idproc: widget.idproc,
//                               noproc: widget.noproc,
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
//     filterProc.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }

//     listProc.forEach((element) {
//       if (element.itemnamegroup.toLowerCase().contains(text) ||
//           element.uomprocname.toLowerCase().contains(text)) {
//         filterProc.add(element);
//       }
//     });
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => Navigator.of(context).pushReplacement(PageRouteBuilder(
//           pageBuilder: (_, __, ___) => SideBarPage(
//                 selectPage: widget.menu,
//               ),
//           transitionDuration: Duration(milliseconds: 750),

//           /// Set animation with opacity
//           transitionsBuilder:
//               (_, Animation<double> animation, __, Widget child) {
//             return Opacity(
//               opacity: animation.value,
//               child: child,
//             );
//           })),
//       child: Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           title: Text('Detail Confirm Receive'),
//           backgroundColor: Colors.red,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.of(context).pushReplacement(
//                 PageRouteBuilder(
//                     pageBuilder: (_, __, ___) => SideBarPage(
//                           selectPage: widget.menu,
//                         ),
//                     transitionDuration: Duration(milliseconds: 750),

//                     /// Set animation with opacity
//                     transitionsBuilder:
//                         (_, Animation<double> animation, __, Widget child) {
//                       return Opacity(
//                         opacity: animation.value,
//                         child: child,
//                       );
//                     })),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Container(
//               color: Color(getColorHexFromStr("#fff5ea")),
//             ),
//             if (isLoading)
//               Form(
//                 key: _formKey,
//                 autovalidate: _autoValidate,
//                 child: ListView(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
//                       alignment: Alignment.topCenter,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 3.0),
//                             child: Text(
//                               "${dataProc.noproc}",
//                               style: TextStyle(
//                                   fontFamily: "Quicksand", fontSize: 22),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 3.0),
//                             child: Text(
//                               dataProc.nameproc,
//                               style: TextStyle(
//                                   fontFamily: "Quicksand", fontSize: 22),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 3.0),
//                             child: Text(
//                               'Total Item: ${listProc.length.toString()}',
//                               style: TextStyle(
//                                   fontFamily: "Quicksand", fontSize: 22),
//                             ),
//                           ),
//                           // Padding(
//                           //   padding: EdgeInsets.only(bottom: 3.0),
//                           //   child: Text(
//                           //     'Total Amount: Rp. ${convertMoney.format(dataProc.totalamount)}',
//                           //     style: TextStyle(
//                           //         fontFamily: "Quicksand", fontSize: 22),
//                           //   ),
//                           // ),
//                           Padding(
//                             padding: EdgeInsets.only(bottom: 3.0),
//                             child: Text(
//                               dataProc.dateproc,
//                               style: TextStyle(
//                                   fontFamily: "Quicksand", fontSize: 22),
//                             ),
//                           ),
//                           Container(
//                             height: 2.0,
//                             width: double.infinity,
//                             color: Colors.black,
//                           ),
//                           // Container(
//                           //   padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
//                           //   child: Material(
//                           //     borderRadius: BorderRadius.circular(7.0),
//                           //     child: TextFormField(
//                           //       controller: filterController,
//                           //       decoration: InputDecoration(
//                           //         border: OutlineInputBorder(
//                           //           borderRadius: BorderRadius.circular(7.0),
//                           //         ),
//                           //         prefixIcon: Icon(
//                           //           Icons.search,
//                           //           color: Colors.black,
//                           //         ),
//                           //         suffixIcon: IconButton(
//                           //           icon: Icon(Icons.cancel),
//                           //           onPressed: () {
//                           //             filterController.clear();
//                           //             onFilterChanged('');
//                           //           },
//                           //         ),
//                           //         contentPadding:
//                           //             EdgeInsets.only(left: 10.0, top: 15.0),
//                           //         hintText: "Search Item Name",
//                           //         hintStyle: TextStyle(color: Colors.grey),
//                           //       ),
//                           //       onChanged: onFilterChanged,
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                     if (filterProc.length > 0 ||
//                         filterController.text.isNotEmpty)
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         itemCount: filterProc.length,
//                         itemBuilder: (context, int index) {
//                           return Container(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 10.0,
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.4,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Text(
//                                                 'Item:',
//                                                 style: TextStyle(
//                                                     fontSize: 16.0,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               Text(
//                                                 '${filterProc[index].itemnamegroup}',
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     color: Colors.black),
//                                               ),
//                                             ],
//                                           ),
//                                           // SizedBox(
//                                           //   height: 10.0,
//                                           // ),

//                                           SizedBox(
//                                             height: 10.0,
//                                           ),
//                                           if (filterProc[index].dateexpired !=
//                                               null)
//                                             Column(
//                                               children: [
//                                                 Text('Expired Date:',
//                                                     style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         fontWeight:
//                                                             FontWeight.bold)),
//                                                 Text(
//                                                     filterProc[index]
//                                                         .dateexpired,
//                                                     style: TextStyle(
//                                                         fontSize: 15.0,
//                                                         color: Colors.black))
//                                               ],
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.4,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           // Column(
//                                           //   children: [
//                                           //     Text('Amount:',
//                                           //         style: TextStyle(
//                                           //             fontSize: 16.0,
//                                           //             fontWeight:
//                                           //                 FontWeight.bold)),
//                                           //     Text(
//                                           //         'Rp. ${convertMoney.format(listProc[index].amount)}',
//                                           //         style: TextStyle(
//                                           //             fontSize: 15.0,
//                                           //             color: Colors.black))
//                                           //   ],
//                                           // ),
//                                           Column(
//                                             children: [
//                                               Text('Qty Proc:',
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                               Text(
//                                                   '${filterProc[index].qtyproc} ${filterProc[index].uomprocname}',
//                                                   style: TextStyle(
//                                                       fontSize: 15.0,
//                                                       color: Colors.black))
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10.0,
//                                           ),
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text('Tanggal:',
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                               Text(
//                                                   '${filterProc[index].dateproc}',
//                                                   style: TextStyle(
//                                                       fontSize: 15.0,
//                                                       color: Colors.black))
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.left,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           hintText: 'Brutto',
//                                         ),
//                                         onChanged: (value) {
//                                           if (value == null || value == '') {
//                                             listProc[index].receivebrutto = 0;
//                                           } else {
//                                             listProc[index].receivebrutto =
//                                                 value.replaceAll(",", ".");
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value.isEmpty) {
//                                             return "Please, isi text";
//                                           } else {
//                                             listProc[index].receivebrutto =
//                                                 value.replaceAll(",", ".");
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Expanded(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.left,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           hintText: 'Netto',
//                                         ),
//                                         onChanged: (value) {
//                                           if (value == null || value == '') {
//                                             listProc[index].receivenetto = 0;
//                                           } else {
//                                             listProc[index].receivenetto =
//                                                 value.replaceAll(",", ".");
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value.isEmpty) {
//                                             return "Please, isi text";
//                                           } else {
//                                             listProc[index].receivenetto =
//                                                 value.replaceAll(",", ".");
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Expanded(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.left,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           hintText: 'Reject',
//                                         ),
//                                         onChanged: (value) {
//                                           if (value == null || value == '') {
//                                             listProc[index].receivereject = 0;
//                                           } else {
//                                             listProc[index].receivereject =
//                                                 value.replaceAll(",", ".");
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value.isEmpty) {
//                                             return "Please, isi text";
//                                           } else {
//                                             listProc[index].receivereject =
//                                                 value.replaceAll(",", ".");
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Align(
//                                           alignment: Alignment.center,
//                                           child:
//                                               // DropdownButton(
//                                               //   hint: Text('Select Uom'),
//                                               //   value: listProc[index].uomreceivingid,
//                                               //   isDense: true,
//                                               //   onChanged: (newValue) {
//                                               //     listProc[index].uomreceivingid =
//                                               //         newValue;
//                                               //     setState(() {});
//                                               //     print(newValue);
//                                               //   },
//                                               //   items: listUom
//                                               //       .map((e) => DropdownMenuItem(
//                                               //             value: e.id,
//                                               //             child: Text(
//                                               //               e.name,
//                                               //               style: TextStyle(
//                                               //                   fontSize: 14.5),
//                                               //             ),
//                                               //           ))
//                                               //       .toList(),
//                                               // ),
//                                               Text(
//                                             'Uom: ${listProc[index].uomgroupname}',
//                                             style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Colors.black),
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5.0,
//                                 ),
//                                 Container(
//                                   height: 2.0,
//                                   width: double.infinity,
//                                   color: Colors.black,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       )
//                     else
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         itemCount: listProc.length,
//                         itemBuilder: (context, int index) {
//                           return Container(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 10.0,
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.4,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Column(
//                                             children: [
//                                               Text(
//                                                 'Item:',
//                                                 style: TextStyle(
//                                                     fontSize: 16.0,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                               Text(
//                                                 '${listProc[index].itemnamegroup}',
//                                                 textAlign: TextAlign.center,
//                                                 style: TextStyle(
//                                                     fontSize: 15.0,
//                                                     color: Colors.black),
//                                               ),
//                                             ],
//                                           ),
//                                           // SizedBox(
//                                           //   height: 10.0,
//                                           // ),

//                                           SizedBox(
//                                             height: 10.0,
//                                           ),
//                                           if (listProc[index].dateexpired !=
//                                               null)
//                                             Column(
//                                               children: [
//                                                 Text('Expired Date:',
//                                                     style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         fontWeight:
//                                                             FontWeight.bold)),
//                                                 Text(
//                                                     listProc[index].dateexpired,
//                                                     style: TextStyle(
//                                                         fontSize: 15.0,
//                                                         color: Colors.black))
//                                               ],
//                                             ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.4,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           // Column(
//                                           //   children: [
//                                           //     Text('Amount:',
//                                           //         style: TextStyle(
//                                           //             fontSize: 16.0,
//                                           //             fontWeight:
//                                           //                 FontWeight.bold)),
//                                           //     Text(
//                                           //         'Rp. ${convertMoney.format(listProc[index].amount)}',
//                                           //         style: TextStyle(
//                                           //             fontSize: 15.0,
//                                           //             color: Colors.black))
//                                           //   ],
//                                           // ),
//                                           Column(
//                                             children: [
//                                               Text('Qty Proc:',
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                               Text(
//                                                   '${listProc[index].qtyproc} ${listProc[index].uomprocname}',
//                                                   style: TextStyle(
//                                                       fontSize: 15.0,
//                                                       color: Colors.black))
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10.0,
//                                           ),
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text('Tanggal:',
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                               Text(
//                                                   '${listProc[index].dateproc}',
//                                                   style: TextStyle(
//                                                       fontSize: 15.0,
//                                                       color: Colors.black))
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.left,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           hintText: 'Brutto',
//                                         ),
//                                         onChanged: (value) {
//                                           if (value == null || value == '') {
//                                             listProc[index].receivebrutto = 0;
//                                           } else {
//                                             listProc[index].receivebrutto =
//                                                 value.replaceAll(",", ".");
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value.isEmpty) {
//                                             return "Please, isi text";
//                                           } else {
//                                             listProc[index].receivebrutto =
//                                                 value.replaceAll(",", ".");
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Expanded(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.left,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           hintText: 'Netto',
//                                         ),
//                                         onChanged: (value) {
//                                           if (value == null || value == '') {
//                                             listProc[index].receivenetto = 0;
//                                           } else {
//                                             listProc[index].receivenetto =
//                                                 value.replaceAll(",", ".");
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value.isEmpty) {
//                                             return "Please, isi text";
//                                           } else {
//                                             listProc[index].receivenetto =
//                                                 value.replaceAll(",", ".");
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Expanded(
//                                       child: TextFormField(
//                                         textAlign: TextAlign.left,
//                                         keyboardType: TextInputType.number,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                           hintText: 'Reject',
//                                         ),
//                                         onChanged: (value) {
//                                           if (value == null || value == '') {
//                                             listProc[index].receivereject = 0;
//                                           } else {
//                                             listProc[index].receivereject =
//                                                 value.replaceAll(",", ".");
//                                           }
//                                         },
//                                         validator: (value) {
//                                           if (value.isEmpty) {
//                                             return "Please, isi text";
//                                           } else {
//                                             listProc[index].receivereject =
//                                                 value.replaceAll(",", ".");
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 5.0,
//                                     ),
//                                     Expanded(
//                                       flex: 1,
//                                       child: Align(
//                                           alignment: Alignment.center,
//                                           child:
//                                               // DropdownButton(
//                                               //   hint: Text('Select Uom'),
//                                               //   value: listProc[index].uomreceivingid,
//                                               //   isDense: true,
//                                               //   onChanged: (newValue) {
//                                               //     listProc[index].uomreceivingid =
//                                               //         newValue;
//                                               //     setState(() {});
//                                               //     print(newValue);
//                                               //   },
//                                               //   items: listUom
//                                               //       .map((e) => DropdownMenuItem(
//                                               //             value: e.id,
//                                               //             child: Text(
//                                               //               e.name,
//                                               //               style: TextStyle(
//                                               //                   fontSize: 14.5),
//                                               //             ),
//                                               //           ))
//                                               //       .toList(),
//                                               // ),
//                                               Text(
//                                             'Uom: ${listProc[index].uomgroupname}',
//                                             style: TextStyle(
//                                                 fontSize: 14.0,
//                                                 color: Colors.black),
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 5.0,
//                                 ),
//                                 Container(
//                                   height: 2.0,
//                                   width: double.infinity,
//                                   color: Colors.black,
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 120.0),
//                       child: RaisedButton(
//                         onPressed: () {
//                           if (_formKey.currentState.validate()) {
//                             _postConfirmReceiveProc();
//                           } else {
//                             setState(() {
//                               _autoValidate = true;
//                             });
//                           }
//                         },
//                         color: Colors.green,
//                         child: Text(
//                           isSubmit ? 'Processing' : 'Confirm Receive',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             else if (tmpMsg == false)
//               Center(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   physics: AlwaysScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   children: <Widget>[
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.2,
//                       child: Card(
//                         elevation: 1.0,
//                         margin: EdgeInsets.all(10.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Data Tidak Tersedia',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 22.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }
