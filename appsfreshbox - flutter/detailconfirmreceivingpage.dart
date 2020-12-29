    // listItemReceive.forEach((element1) {
    //   element1.data.forEach((element2) {
    //     if (element2.itemGroupProc.namegroup
    //             .toLowerCase()
    //             .contains(text.toLowerCase()) ||
    //         element2.trxProcurement2.userProc.user.name
    //             .toLowerCase()
    //             .contains(text.toLowerCase())) {
    //       tmp2.add(element2.toJson());
    //     }
    //   });
    //   // tmplistItemReceive.addAll(element1);
    //   Map<String, dynamic> data = {
    //     'item_name_group': element1.itemnamegroup,
    //     'uom_group_name': element1.uomgroupname,
    //     'receive_brutto': element1.receivingbrutto,
    //     'receive_netto': element1.receivingnetto,
    //     'receive_reject': element1.receivingreject,
    //     'data': tmp2
    //   };

    //   tmp3.add(data);

    //   tmplistItemReceive = tmp3
    //       .map<TmpReceiving>((json) => TmpReceiving.fromJson(json))
    //       .toList();
    // });
    
                                      // tmplistItemReceive[index1].data.length > 0
                                      //     ? Padding(
                                      //         padding: const EdgeInsets.only(
                                      //             top: 10.0,
                                      //             left: 20.0,
                                      //             bottom: 20.0),
                                      //         child: Align(
                                      //           alignment: Alignment.centerLeft,
                                      //           child: Text(
                                      //             '${tmplistItemReceive[index1].data[0].itemGroupProc.namegroup}',
                                      //             style: TextStyle(
                                      //               fontSize: 16.0,
                                      //               fontWeight: FontWeight.bold,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       )
                                      //     : Text(''),
                                      
                                      
                                        // title: tmplistItemReceive[index1]
                                        //             .data
                                        //             .length >
                                        //         0
                                        //     ?
                                        
                                        
  // tmplistItemReceive[index1].data.length > 0
                                      //     ? ListView.builder(
                                      //         shrinkWrap: true,
                                      //         physics:
                                      //             NeverScrollableScrollPhysics(),
                                      //         scrollDirection: Axis.vertical,
                                      //         itemCount:
                                      //             tmplistItemReceive[index1]
                                      //                 .data
                                      //                 .length,
                                      //         itemBuilder: (context, index2) {
                                      //           return Column(
                                      //             children: [
                                      //               Text(
                                      //                 'Procurement: ${tmplistItemReceive[index1].data[index2].trxProcurement2.userProc.user.name}',
                                      //                 style: TextStyle(
                                      //                     fontSize: 16.0,
                                      //                     fontWeight:
                                      //                         FontWeight.bold),
                                      //               ),
                                      //               SizedBox(
                                      //                 height: 3.0,
                                      //               ),
                                      //               Text(
                                      //                 'Uom Procurement: ${tmplistItemReceive[index1].data[index2].uomProc.name}',
                                      //                 style: TextStyle(
                                      //                     fontSize: 14.0),
                                      //               ),
                                      //               SizedBox(
                                      //                 height: 5.0,
                                      //               ),
                                      //               Text(
                                      //                 'Tanggal: ${tmplistItemReceive[index1].data[index2].dateproc}',
                                      //                 style: TextStyle(
                                      //                     fontSize: 14.0),
                                      //               ),
                                      //               SizedBox(
                                      //                 height: 10.0,
                                      //               ),
                                      //               RaisedButton(
                                      //                 onPressed: () {
                                      //                   setState(() {
                                      //                     tmplistItemReceive[
                                      //                             index1]
                                      //                         .data
                                      //                         .removeWhere((element) =>
                                      //                             element
                                      //                                 .idtrxprocurement ==
                                      //                             tmplistItemReceive[
                                      //                                     index1]
                                      //                                 .data[
                                      //                                     index2]
                                      //                                 .idtrxprocurement);
                                      //                   });
                                      //                 },
                                      //                 color: Colors.grey,
                                      //                 child: Text(
                                      //                   'Cancel',
                                      //                   style: TextStyle(
                                      //                       color:
                                      //                           Colors.white),
                                      //                 ),
                                      //               ),
                                      //               SizedBox(
                                      //                 height: 20.0,
                                      //               ),
                                      //             ],
                                      //           );
                                      //         },
                                      //       )
                                      //     : Center(
                                      //         child: ListView(
                                      //           shrinkWrap: true,
                                      //           padding: EdgeInsets.symmetric(
                                      //               horizontal: 20.0,
                                      //               vertical: 10.0),
                                      //           scrollDirection: Axis.vertical,
                                      //           physics:
                                      //               NeverScrollableScrollPhysics(),
                                      //           children: <Widget>[
                                      //             Container(
                                      //               height:
                                      //                   MediaQuery.of(context)
                                      //                           .size
                                      //                           .height *
                                      //                       0.15,
                                      //               child: Card(
                                      //                 elevation: 1.0,
                                      //                 margin:
                                      //                     EdgeInsets.all(10.0),
                                      //                 shape:
                                      //                     RoundedRectangleBorder(
                                      //                   borderRadius:
                                      //                       BorderRadius
                                      //                           .circular(15.0),
                                      //                 ),
                                      //                 child: Center(
                                      //                   child: Text(
                                      //                     'Data Tidak Tersedia. Silkan Pilih Item Terlebih Dahulu',
                                      //                     textAlign:
                                      //                         TextAlign.center,
                                      //                     style: TextStyle(
                                      //                         color:
                                      //                             Colors.black,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                         fontSize: 22.0),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      
   // listItemReceive[index1].data.length > 0
                                        //     ? Padding(
                                        //         padding: const EdgeInsets.only(
                                        //             top: 10.0,
                                        //             left: 20.0,
                                        //             bottom: 20.0),
                                        //         child: Align(
                                        //           alignment:
                                        //               Alignment.centerLeft,
                                        //           child: Text(
                                        //             '${listItemReceive[index1].data[0].itemGroupProc.namegroup}',
                                        //             style: TextStyle(
                                        //               fontSize: 16.0,
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       )
                                        //     : Text(''),
                                        
  // listItemReceive[index1].data.length > 0
                                        //     ? ListView.builder(
                                        //         shrinkWrap: true,
                                        //         physics:
                                        //             NeverScrollableScrollPhysics(),
                                        //         scrollDirection: Axis.vertical,
                                        //         itemCount:
                                        //             listItemReceive[index1]
                                        //                 .data
                                        //                 .length,
                                        //         itemBuilder: (context, index2) {
                                        //           return Column(
                                        //             children: [
                                        //               Text(
                                        //                 'Procurement: ${listItemReceive[index1].data[index2].trxProcurement2.userProc.user.name}',
                                        //                 style: TextStyle(
                                        //                     fontSize: 16.0,
                                        //                     fontWeight:
                                        //                         FontWeight
                                        //                             .bold),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 3.0,
                                        //               ),
                                        //               Text(
                                        //                 'Uom Procurement: ${listItemReceive[index1].data[index2].uomProc.name}',
                                        //                 style: TextStyle(
                                        //                     fontSize: 14.0),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 3.0,
                                        //               ),
                                        //               Text(
                                        //                 'Tanggal: ${listItemReceive[index1].data[index2].dateproc}',
                                        //                 style: TextStyle(
                                        //                     fontSize: 14.0),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 10.0,
                                        //               ),
                                        //               RaisedButton(
                                        //                 onPressed: () {
                                        //                   setState(() {
                                        //                     listItemReceive[
                                        //                             index1]
                                        //                         .data
                                        //                         .removeWhere((element) =>
                                        //                             element
                                        //                                 .idtrxprocurement ==
                                        //                             listItemReceive[
                                        //                                     index1]
                                        //                                 .data[
                                        //                                     index2]
                                        //                                 .idtrxprocurement);
                                        //                   });
                                        //                 },
                                        //                 color: Colors.grey,
                                        //                 child: Text(
                                        //                   'Cancel',
                                        //                   style: TextStyle(
                                        //                       color:
                                        //                           Colors.white),
                                        //                 ),
                                        //               ),
                                        //               SizedBox(
                                        //                 height: 20.0,
                                        //               ),
                                        //             ],
                                        //           );
                                        //         },
                                        //       )
                                        //     : Center(
                                        //         child: ListView(
                                        //           shrinkWrap: true,
                                        //           padding: EdgeInsets.symmetric(
                                        //               horizontal: 20.0,
                                        //               vertical: 10.0),
                                        //           scrollDirection:
                                        //               Axis.vertical,
                                        //           physics:
                                        //               NeverScrollableScrollPhysics(),
                                        //           children: <Widget>[
                                        //             Container(
                                        //               height:
                                        //                   MediaQuery.of(context)
                                        //                           .size
                                        //                           .height *
                                        //                       0.15,
                                        //               child: Card(
                                        //                 elevation: 1.0,
                                        //                 margin: EdgeInsets.all(
                                        //                     10.0),
                                        //                 shape:
                                        //                     RoundedRectangleBorder(
                                        //                   borderRadius:
                                        //                       BorderRadius
                                        //                           .circular(
                                        //                               15.0),
                                        //                 ),
                                        //                 child: Center(
                                        //                   child: Text(
                                        //                     'Data Tidak Tersedia. Silkan Pilih Item Terlebih Dahulu',
                                        //                     textAlign: TextAlign
                                        //                         .center,
                                        //                     style: TextStyle(
                                        //                         color: Colors
                                        //                             .black,
                                        //                         fontWeight:
                                        //                             FontWeight
                                        //                                 .bold,
                                        //                         fontSize: 22.0),
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        
  
