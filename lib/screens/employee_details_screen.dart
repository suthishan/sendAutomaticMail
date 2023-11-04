import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:task_one/services/models/transaction_details_model.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final TransactionDetails employeeInfo;
  const EmployeeDetailsScreen({super.key, required this.employeeInfo});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late ThemeData themeData;
  @override
  void initState() {
    super.initState();
    // call db
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Digital Report'),
            leading: BackArrowButton(
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: SafeArea(
            child: KeyboardDismissOnTap(
          child: employeeScreenUI(),
        )));
  }

  Widget employeeScreenUI() {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }
}

class BackArrowButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackArrowButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }
}
