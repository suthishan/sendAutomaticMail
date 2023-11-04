import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart';
import 'package:task_one/services/database/database.dart';
import 'package:task_one/services/models/transaction_details_model.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ThemeData themeData;

  List<TransactionDetail> filterList = [];
  TransactionDetail? transactionDetail;

  @override
  void initState() {
    super.initState();
    // call db

    getData();
  }

  getData() async {
    // filterList = await DataBase.instance.getProductList();

    //   await DataBase.instance.insertData();
    filterList = await DataBase.instance.getData();

    for (TransactionDetail trans in filterList) {
      if (trans.status == 'Error') {
        return await sendEmail(trans);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Task 1'),
      ),
      body: SafeArea(
          child: KeyboardDismissOnTap(
        child: homeScreenUI(),
      )),
    );
  }

  Widget homeScreenUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Align(
            child: Text(
              'Send Automatic email if there is error in transaction status',
              style: themeData.textTheme.headline6,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  // method 1
  Future<void> send() async {
    Email sendEmail = Email(
      body: 'This record contains error in it.',
      subject: 'Error record',
      recipients: ['vadarsh22@gmail.com'],
      // cc: ['vadarsh22@gmail.com'],
      // bcc: ['vadarsh22@gmail.com'],
      // attachmentPaths: ['/path/to/email_attachment.zip'],

      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(sendEmail);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

// method 2
  Future<void> sendEmail(
    TransactionDetail transaction,
    //{
    // required String name,
    // required String email,
    // required String subject,
    // required String message,
    // }
  ) async {
    String serviceId = 'service_vq6qb1e';
    String templateId = 'template_cies52h';
    String userId = 'ixbInqlpsFL6K0yGf';

    Uri url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    Response response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        "user_id": userId,
        'template_params': {
          'to_email': 'vadarsh22@gmail.com',
          'user_name': 'Adarsh',
          'user_email': 'Hello',
          'user_subject': 'error',
          'to_name': 'Adarsh',
          'from_name': 'Adarsh',
          'message':
              'The transaction data at ${transaction.time} has failed due to an error',
        }
      }),
    );
    print(response.statusCode);
    // check status
    if (response.statusCode == 200) {
      transactionDetail = transaction;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Email Sent Successfully! to vadarsh22@gmail.com',
            style: themeData.textTheme.subtitle1,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Error in sending email',
            style: themeData.textTheme.subtitle1,
          ),
        ),
      );
    }
  }
}
