import 'package:esales_training/models/StatusModel.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

Widget StatusDialog(BuildContext context, Function(String) function) {
  List<StatusModel> dataStm = StatusModel.statusList;
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    child: Container(
      height: 340,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(0, 44, 195, 1),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chọn Trạng Thái",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            StatefulBuilder(builder: (context, setState) {
              return Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: dataStm.length,
                  itemBuilder: (context, i) {
                    return RadioListTile(
                      title: Text(dataStm[i].statusName),
                      value: dataStm[i].statusCode,
                      groupValue: statusRadio,
                      onChanged: (val) => setState(() {
                        statusRadio = val;
                        stCode = statusRadio;
                        status = dataStm[i].statusName;
                      }),
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  },
                ),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    child: ElevatedButton(
                      child: Text('Đồng Ý'),
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 44, 195, 1),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        function(status);
                        Navigator.pop(context);
                        // setState(() {});
                      },
                    ),
                  ),
                  Container(
                    width: 120,
                    child: ElevatedButton(
                      child: Text('Đóng'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white70,
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
