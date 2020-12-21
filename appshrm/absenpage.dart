// _getLocOffice() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   if (mounted) {
  //     AbsenController()
  //         .getLocOffice(localStorage.getString('nikEmployee'))
  //         .then((value) {
  //       if (value.length > 0) {
  //         if (!mounted) return;
  //         setState(() {
  //           isLoad = true;
  //           lngOffice = value[0]['longtitude'];
  //           latOffice = value[0]['latitude'];
  //           minDistance = value[0]['minDistance'];
  //           officeName = value[0]['nama_lokasi'];

  ///[get maps real time dengan location]
  // location.onLocationChanged.listen((LocationData currentLocation) {
  //   lngMobile = currentLocation.longitude;
  //   latMobile = currentLocation.latitude;
  //   double tmpCalculateDistance = calculateDistance(
  //       currentLocation.latitude,
  //       currentLocation.longitude,
  //       latOffice,
  //       lngOffice);
  //   totalDistance =
  //       tmpCalculateDistance.toMeter(LengthUnit.kilometer);
  //   tmpTotalDistance = totalDistance.round();
  //   print(totalDistance.round().toString());
  // });

  ///[get maps real time dengan geolocator]
  //           StreamSubscription<Position> positionStream =
  //               Geolocator.getPositionStream(
  //                       desiredAccuracy: LocationAccuracy.bestForNavigation)
  //                   .listen((Position position) {
  //             if (!mounted) return;
  //             setState(() {
  //               lngMobile = position.longitude;
  //               latMobile = position.latitude;
  //               var x = calculateDistance(position.latitude, position.longitude,
  //                   latOffice, lngOffice);
  //               totalDistance = x.toMeter(LengthUnit.kilometer);
  //               tmpTotalDistance = totalDistance.round();
  //             });
  //           });
  //         });
  //       } else if (value.length == 0) {
  //         if (!mounted) return;
  //         setState(() {
  //           isLoad = false;
  //         });
  //       } else {
  //         setState(() {
  //           WidgetsBinding.instance.addPostFrameCallback((_) async {
  //             await showDialog<String>(
  //               context: context,
  //               builder: (BuildContext context) => new AlertDialog(
  //                 title: new Text("Pemberitahuan!"),
  //                 content: new Text("Koneksi Putus, \nSilakan Coba Lagi"),
  //                 actions: <Widget>[
  //                   new FlatButton(
  //                     child: new Text("OK"),
  //                     onPressed: () {
  //                       Navigator.of(context).pushReplacement(PageTransition(
  //                           child: OnBoardingPage(),
  //                           type: PageTransitionType.fade,
  //                           ctx: context));
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             );
  //           });
  //         });
  //       }
  //     });
  //   }
  // }

  /// [function calculate between latlong]
  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }
  
  
  // else
                        // ListView(
                        //   padding: EdgeInsets.zero,
                        //   physics: AlwaysScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   children: <Widget>[
                        //     Container(
                        //       height:
                        //           MediaQuery.of(context).size.height * 0.25,
                        //       child: Card(
                        //         elevation: 1.0,
                        //         margin: EdgeInsets.all(10.0),
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(15.0),
                        //         ),
                        //         child: Center(
                        //           child: Text(
                        //             'Maaf, \nDevices Anda Belum Didukung FingerPrint',
                        //             style: TextStyle(
                        //                 color: Colors.black,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 22.0),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
  
  
  // var x = calculateDistance(
                                        //     position.latitude,
                                        //     position.longitude,
                                        //     latOffice,
                                        //     lngOffice);
                                        // totalDistance =
                                        //     x.toMeter(LengthUnit.kilometer);
                                        
                                                                                // tmpTotalDistance = totalDistance.round();
