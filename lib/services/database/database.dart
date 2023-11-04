import 'package:task_one/services/database/sqlite_db.dart';
import 'package:task_one/services/models/transaction_details_model.dart';

class DataBase {
  DataBase._internal();
  static DataBase instance = DataBase._internal();

  Future<bool> insertData() async {
    //  DateFormat dateFormat = DateFormat("dd-MM-yy hh:mm");
    List<TransactionDetail> list = [];

    list = [
      TransactionDetail(
          description: 'UpdateTask',
          id: 1,
          status: 'Success',
          time: DateTime(
            2020,
            12,
            5,
            10,
            00,
          )),
      TransactionDetail(
          description: 'UpdateStatus',
          id: 2,
          status: 'Pending',
          time: DateTime(2020, 12, 5, 11, 00)),
      TransactionDetail(
          description: 'UpdatePerson',
          id: 3,
          status: 'Error',
          time: DateTime(
            2020,
            12,
            5,
            11,
            02,
          )),
      TransactionDetail(
          description: 'UpdateTask',
          id: 4,
          status: 'Success',
          time: DateTime(
            2020,
            13,
            5,
            10,
            00,
          )),
      TransactionDetail(
          description: 'UpdateStatus',
          id: 5,
          status: 'Pending',
          time: DateTime(
            2020,
            13,
            5,
            11,
            00,
          ))
    ];

    try {
      for (TransactionDetail emp in list) {
        print(emp.toJson());
        TransactionDetail i =
            await TransactionDetailDataBase.instance.create(emp);
        print('-----------');
        print(i);
      }
    } catch (e) {
      print('-------$e');
      return false;
    }
    return true;
  }

  Future<List<TransactionDetail>> getData() async {
    List<TransactionDetail> list = [];
    list = await TransactionDetailDataBase.instance.readAllDocuments();

    return list;
  }
}
