//Attendance
  // 142.93.48.44

  getReportlog(data) async {
    var urls = 'http://142.93.48.44:8998/api/getAbsensiLogMonthEmp';
    return await http.post(urls, body: jsonEncode(data), headers: {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    });
  }

  getReportattendance(data) async {
    var urls = 'http://142.93.48.44:8998/api/getAbsensiMonth';
    return await http.post(urls, body: jsonEncode(data), headers: {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    });
  }

  postFormTgsLr(data) async {
    var urls = 'http://142.93.48.44:8998/api/formTgsLr';
    return await http.post(urls, body: jsonEncode(data), headers: {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    });
  }

  getLeaveType() async {
    var urls = "http://142.93.48.44:8998/api/getLeaveType";
    return await http.get(urls, headers: {
      'Accept': 'application/json',
    });
  }

  getHistoryFrom(String scanid) async {
    var urls = 'http://142.93.48.44:8998/api/getHistoryForm';
    return await http.post(urls, body: {
      'scan_id': scanid.toString()
    }, headers: {
      'Accept': 'application/json',
    });
  }

  getAbsenNow(String scanid) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var urls = 'http://142.93.48.44:8998/api/getAttendanceNow';
    return await http.post(urls, body: {
      'nik': scanid.toString(),
      'tgl': formattedDate
      // 'tgl': '2020-10-14'
    }, headers: {
      'Accept': 'application/json',
    });
  }

  getLngLat(String scanid) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var urls = 'http://142.93.48.44:8998/api/getLngLat';
    return await http.post(urls, body: {
      'nik': scanid.toString(),
      'tgl': formattedDate
      // 'tgl': '2020-10-14'
    }, headers: {
      'Accept': 'application/json',
    });
  }

  signIn(String scanid, double long, double lat) async {
    var urls = 'http://142.93.48.44:8998/api/signIn';
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(now);
    return await http.post(urls, body: {
      'nik': scanid.toString(),
      'scan_at': formattedDate,
      'long': long.toString(),
      'lat': lat.toString(),
    }, headers: {
      'Accept': 'application/json',
    });
  }

  signOut(String scanid, double long, double lat) async {
    var urls = 'http://142.93.48.44:8998/api/signOut';
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(now);
    return await http.post(urls, body: {
      'nik': scanid.toString(),
      'scan_at': formattedDate,
      'long': long.toString(),
      'lat': lat.toString(),
    }, headers: {
      'Accept': 'application/json',
    });
  }
