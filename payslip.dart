import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hrms/view_payslip.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:pspdfkit_flutter/src/main.dart';

class payslip extends StatefulWidget {
  const payslip({Key? key}) : super(key: key);

  @override
  State<payslip> createState() => _payslipState();
}

class _payslipState extends State<payslip> {
  var fileName = '/pspdfkit-flutter-quickstart-guide.pdf';
  var year;
  var month;
  var storage = FlutterSecureStorage();
  bool trydown = false;
  var reason = '';

  Future fetchAlbum(BuildContext context) async {
    bool trylog = false;
    var session = await storage.read(key: 'cookie');
    Map<String, dynamic> jsonMap = {
      "month": month,
      "year": year,
    };
    print(jsonMap);

    final uri = Uri.parse(
        'https://hrmsprime.com/my_services_api/partner/get_payslip_id');

    final response =
        await http.get(uri.replace(queryParameters: jsonMap), headers: {
      "Cookie": session.toString(),
    });
    print("Response:"+response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var det = jsonDecode(response.body);

      if (det['status'] == 'success') {
        var url = det['url'];
        setState(() {
          reason = 'Downloading...';
          trydown = true;
        });
        print("url   "+url);


            
      
      } else {
        reason = det['reason'];
        setState(() {
          trydown = true;
        });
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'PAYSLIP',
        ),
        centerTitle: true,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  hint: Text("Select Year"),
                  //isExpanded: true, // here need to change
                  value: year,
                  onChanged: (newValue) {
                    setState(() {
                      year = newValue!;
                    });
                  },
                  items: <String>[
                    '2022',
                    '2021',
                    '2020',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
                DropdownButton(
                  hint: Text("Select Month"),
                  //isExpanded: true, // here need to change
                  value: month,
                  onChanged: (newValue) {
                    setState(() {
                      month = newValue!;
                    });
                  },
                  items: <String>[
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '10',
                    '11',
                    '12',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black87,
              minimumSize: Size(300, 60),
              padding: EdgeInsets.all(25),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            onPressed: year == null || month == null
                ? null
                : () {
                    fetchAlbum(context);
                  },
            child: Text(
              'Download Payslip',
              style: TextStyle(
                color: Colors.white,
              ),
            
              ),
            ),
            
            
            SizedBox(height: 30,),

            ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black87,
              minimumSize: Size(300, 60),
              padding: EdgeInsets.all(25),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
            onPressed: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PDF().cachedFromUrl(
             'https://www.tutorialspoint.com/flutter/flutter_tutorial.pdf',
              maxAgeCacheObject:Duration(days: 30), //duration of cache
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
           )
                    ));
            },
            child: Text(
              ' Payslip',
              style: TextStyle(
                color: Colors.white,
              ),
              
              ),
            ),
          if (trydown) Text(reason),
        ],
      )),
    );
  }
}
