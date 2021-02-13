// responseHome = await Services().getDetailOrderHomeQc(widget.orderid);
    // responseHold = await Services().getDetailOrderPickQc(widget.orderid);
    // responsePending = await Services().getDetailOrderPendingQc(widget.orderid);
    // responseConfrim = await Services().getDetailOrderConfrimQc(widget.orderid);
    // if (responseHome.statusCode == 200) {
    //   if (!mounted) return;
    //   setState(() {
    //     var tmpRes = jsonDecode(responseHome.body)['data'][0];
    //     dataOrder = Dataorder.fromJson(tmpRes);
    //     detailOrder = dataOrder.detailorder;
    //     for (var i = 0; i < detailOrder.length; i++) {
    //       if (dataOrder.pickstatus == 2 && dataOrder.shieldstatus == 2) {
    //         detailOrder[i].qtyqc = detailOrder[i].qtyqcreject;
    //       }
    //     }
    //     isLoading = true;
    //   });
    // } else if (responseHold.statusCode == 200) {
    //   if (!mounted) return;
    //   setState(() {
    //     var tmpRes = jsonDecode(responseHold.body)['data'][0];
    //     dataOrder = Dataorder.fromJson(tmpRes);
    //     detailOrder = dataOrder.detailorder;
    //     for (var i = 0; i < detailOrder.length; i++) {
    //       if (dataOrder.pickstatus == 2 && dataOrder.shieldstatus == 2) {
    //         detailOrder[i].qtyqc = detailOrder[i].qtyqcreject;
    //       }
    //     }
    //     isLoading = true;
    //   });
    // } else if (responsePending.statusCode == 200) {
    //   if (!mounted) return;
    //   setState(() {
    //     var tmpRes = jsonDecode(responsePending.body)['data'][0];
    //     dataOrder = Dataorder.fromJson(tmpRes);
    //     var tmpBoxed = dataOrder.boxed;
    //     boxS = int.parse(tmpBoxed.split(",")[0]);
    //     boxM = int.parse(tmpBoxed.split(",")[1]);
    //     boxL = int.parse(tmpBoxed.split(",")[2]);
    //     boxXL = int.parse(tmpBoxed.split(",")[3]);
    //     detailOrder = dataOrder.detailorder;
    //     for (var i = 0; i < detailOrder.length; i++) {
    //       if (dataOrder.pickstatus == 2 && dataOrder.shieldstatus == 2) {
    //         detailOrder[i].qtyqc = detailOrder[i].qtyqcreject;
    //       }
    //     }
    //     isLoading = true;
    //   });
    // } else if (responseConfrim.statusCode == 200) {
    //   if (!mounted) return;
    //   setState(() {
    //     var tmpRes = jsonDecode(responseConfrim.body)['data'][0];
    //     dataOrder = Dataorder.fromJson(tmpRes);
    //     var tmpBoxed = dataOrder.boxed;
    //     boxS = int.parse(tmpBoxed.split(",")[0]);
    //     boxM = int.parse(tmpBoxed.split(",")[1]);
    //     boxL = int.parse(tmpBoxed.split(",")[2]);
    //     boxXL = int.parse(tmpBoxed.split(",")[3]);
    //     for (var i = 0; i < detailOrder.length; i++) {
    //       if (dataOrder.pickstatus == 2 && dataOrder.shieldstatus == 2) {
    //         detailOrder[i].qtyqc = detailOrder[i].qtyqcreject;
    //       }
    //     }
    //     detailOrder = dataOrder.detailorder;
    //     isLoading = true;
    //   });
    // } else if (responseHome.statusCode == 401 ||
    //     responseHold.statusCode == 401 ||
    //     responsePending.statusCode == 401 ||
    //     responseConfrim.statusCode == 401) {
    //   setState(() {
    //     var body = jsonDecode(responseHome.body);
    //     tmpMsg = body['success'];
    //     tmpOrderid = body['orderid'];
    //     tmpQc = body['qc'];
    //     tmpQcat = body['qc_at'];
    //     body['status'] == 1
    //         ? tmpStatus = "Hold"
    //         : body['status'] == 2
    //             ? tmpStatus = "Pending"
    //             : tmpStatus = "Confrim";
    //     print(tmpMsg);
    //     final snackBar = SnackBar(
    //       content: Text("Order Sudah Di Pick"),
    //       action: SnackBarAction(
    //         label: 'Close',
    //         textColor: Colors.white,
    //         onPressed: () => Navigator.pushReplacement(
    //           context,
    //           new MaterialPageRoute(
    //               builder: (context) => SideBarPage(selectPage: widget.menu)),
    //         ),
    //       ),
    //       duration: new Duration(minutes: 30),
    //       backgroundColor: Colors.red,
    //     );
    //     _scaffoldKey.currentState.showSnackBar(snackBar);
    //   });
    // }

// SingleChildScrollView dataQc() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: DataTable(
  //         horizontalMargin: MediaQuery.of(context).size.width * 0.05,
  //         columnSpacing: MediaQuery.of(context).size.width * 0.14,
  //         headingRowHeight: MediaQuery.of(context).size.height * 0.1,
  //         dataRowHeight: MediaQuery.of(context).size.height * 0.17,
  //         columns: [
  //           DataColumn(
  //             label: Center(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width * 0.3,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Text("Qty dan Item"),
  //                     SizedBox(
  //                       height: 2.0,
  //                     ),
  //                     Text("(${dataOrder.qcname.split(" ")[0]})")
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           DataColumn(
  //             label: Center(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width * 0.12,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Text(
  //                       "Qty",
  //                     ),
  //                     Text(
  //                       "(Order)",
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           DataColumn(
  //             label: Container(
  //               width: MediaQuery.of(context).size.width * 0.13,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Text("Remarks"),
  //                   Text("(${dataOrder.qcname.split(" ")[0]})")
  //                 ],
  //               ),
  //             ),
  //           ),
  //           DataColumn(
  //             label: Container(
  //               width: MediaQuery.of(context).size.width * 0.13,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: <Widget>[
  //                   Text("Remarks"),
  //                   Text("(${dataOrder.pickedname.split(" ")[0]})")
  //                 ],
  //               ),
  //             ),
  //           ),
  //           DataColumn(
  //             label: Center(
  //               child: Container(
  //                 width: MediaQuery.of(context).size.width * 0.12,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Text("Qty"),
  //                     SizedBox(
  //                       height: 2.0,
  //                     ),
  //                     Text("(${dataOrder.pickedname.split(" ")[0]})")
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //         rows: detailOrder
  //             .asMap()
  //             .map(
  //               (i, element) => MapEntry(
  //                 i,
  //                 DataRow(
  //                   cells: [
  //                     DataCell(dataOrder.ecommercename == "B2B Freshbox"
  //                         ? TextFormField(
  //                             keyboardType: TextInputType.number,
  //                             onChanged: (value) {
  //                               element.qtyqc = value;
  //                             },
  //                           )
  //                         : dataOrder.shieldstatus == 3
  //                             ? Container(
  //                                 width:
  //                                     MediaQuery.of(context).size.width * 0.3,
  //                                 height:
  //                                     MediaQuery.of(context).size.height * 0.3,
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: <Widget>[
  //                                     Text(
  //                                       element.qtyqc,
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           fontFamily: "Quicksand",
  //                                           fontSize: 16.0,
  //                                           fontWeight: FontWeight.bold),
  //                                     ),
  //                                     SizedBox(
  //                                       height: 2.0,
  //                                     ),
  //                                     Text(
  //                                       '${element.skuname}',
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               )
  //                             : Container(
  //                                 width:
  //                                     MediaQuery.of(context).size.width * 0.3,
  //                                 height:
  //                                     MediaQuery.of(context).size.height * 0.3,
  //                                 child: Column(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: <Widget>[
  //                                     Row(
  //                                       mainAxisSize: MainAxisSize.min,
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.center,
  //                                       children: <Widget>[
  //                                         Container(
  //                                           width: 20.0,
  //                                           height: 20.0,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.grey[400],
  //                                             borderRadius:
  //                                                 BorderRadius.circular(5.0),
  //                                           ),
  //                                           child: InkWell(
  //                                             onTap: () {
  //                                               tmpQtypicker =
  //                                                   int.parse(element.qtyqc);
  //                                               if (tmpQtypicker > 0) {
  //                                                 setState(() {
  //                                                   tmpQtypicker--;
  //                                                   element.qtyqc =
  //                                                       tmpQtypicker.toString();
  //                                                   print(tmpQtypicker);
  //                                                 });
  //                                               }
  //                                             },
  //                                             child: Align(
  //                                               alignment: Alignment.center,
  //                                               child: Icon(
  //                                                 Icons.remove,
  //                                                 color: Colors.white,
  //                                                 size: 15.0,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         Padding(
  //                                           padding: EdgeInsets.symmetric(
  //                                               horizontal: 8.0),
  //                                           child: Text(
  //                                             element.qtyqc,
  //                                             style: TextStyle(
  //                                                 fontFamily: "Quicksand",
  //                                                 fontSize: 16.0,
  //                                                 fontWeight: FontWeight.bold),
  //                                           ),
  //                                         ),
  //                                         Container(
  //                                           width: 20.0,
  //                                           height: 20.0,
  //                                           decoration: BoxDecoration(
  //                                             color: Colors.red[400],
  //                                             borderRadius:
  //                                                 BorderRadius.circular(5.0),
  //                                           ),
  //                                           child: InkWell(
  //                                             onTap: () {
  //                                               tmpQtypicker =
  //                                                   int.parse(element.qtyqc);
  //                                               if (tmpQtypicker <
  //                                                   int.parse(element.qty)) {
  //                                                 setState(() {
  //                                                   tmpQtypicker++;
  //                                                   element.qtyqc =
  //                                                       tmpQtypicker.toString();
  //                                                   print(tmpQtypicker);
  //                                                 });
  //                                               }
  //                                             },
  //                                             child: Icon(
  //                                               Icons.add,
  //                                               color: Colors.white,
  //                                               size: 15.0,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     SizedBox(
  //                                       height: 2.0,
  //                                     ),
  //                                     Text(
  //                                       '${element.skuname}',
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               )),
  //                     DataCell(
  //                       Center(
  //                         child: Text(
  //                           element.qty,
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               fontFamily: "Quicksand",
  //                               fontSize: 16.0,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ),
  //                     DataCell(
  //                       dataOrder.shieldstatus == 3
  //                           ? Text(
  //                               element.remakrsqc,
  //                               style: TextStyle(
  //                                   fontFamily: "Quicksand",
  //                                   fontSize: 16.0,
  //                                   fontWeight: FontWeight.bold),
  //                             )
  //                           : DropdownButton(
  //                               hint: Text("Remakrs"),
  //                               value: element.remakrsqc ?? "Accept",
  //                               items: _remarks.map((item) {
  //                                 return DropdownMenuItem(
  //                                   child: Text(item.name),
  //                                   value: item.name,
  //                                 );
  //                               }).toList(),
  //                               onChanged: (value) {
  //                                 element.remakrsqc = value;
  //                                 setState(() {});
  //                                 print(element.remakrsqc);
  //                               },
  //                             ),
  //                     ),
  //                     DataCell(
  //                       Text(
  //                         element.remakrspicker,
  //                         style: TextStyle(
  //                             fontFamily: "Quicksand",
  //                             fontSize: 16.0,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     ),
  //                     DataCell(
  //                       Center(
  //                         child: Text(
  //                           element.qtypicker,
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                               fontFamily: "Quicksand",
  //                               fontSize: 16.0,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //             .values
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }
