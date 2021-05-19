import 'package:esales_training/model/ReceiveWarrantyCardModel.dart';
import 'package:esales_training/model/StatusModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class DanhSachPhieu extends StatefulWidget {
  const DanhSachPhieu({Key key}) : super(key: key);

  @override
  _DanhSachPhieuState createState() => _DanhSachPhieuState();
}

class _DanhSachPhieuState extends State<DanhSachPhieu>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String statusBill;
  String status;
  Color color;

  bool allstatus = false;
  bool pendingstatus = false;
  bool donestatus = false;
  bool cancelstatus = false;

  int statusRadio;
  int stCode;
  int lengthDays;

  DateTime pickedFrom;
  DateTime pickedTo;
  DateTime timeSort;
  DateTime parseTime;

  ReceiveWarrantyCardModel rwcm;
  List<ReceiveWarrantyCardModel> data = ReceiveWarrantyCardModel.RWCList;
  List<ReceiveWarrantyCardModel> dataSort = ReceiveWarrantyCardModel.RWCList;
  List<ReceiveWarrantyCardModel> dataDateSort = [];

  StatusModel stm;
  List<StatusModel> dataStm = StatusModel.statusList;

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  Future<Null> _selectDateFrom(BuildContext context) async {
    pickedFrom = await showDatePicker(
      context: context,
      initialDate: selectedDateFrom,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedFrom != null &&
        pickedFrom != selectedDateFrom &&
        pickedFrom.isBefore(selectedDateTo))
      setState(() {
        selectedDateFrom = pickedFrom;
        dateFilter();
      });
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    pickedTo = await showDatePicker(
      context: context,
      initialDate: selectedDateTo,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedTo != null &&
        pickedTo != selectedDateTo &&
        pickedTo.isAfter(selectedDateFrom))
      setState(() {
        selectedDateTo = pickedTo;
        dateFilter();
      });
  }

  dateFilter() {
    setState(() {
      dataDateSort.clear();
      lengthDays = selectedDateTo.difference(selectedDateFrom).inDays;
      for (int i = 0; i <= lengthDays; i++) {
        timeSort = DateTime.utc(selectedDateFrom.year, selectedDateFrom.month,
            selectedDateFrom.day + i);
        for (var x in data) {
          parseTime = DateTime.parse(x.createDate);
          if (parseTime.day == timeSort.day &&
              parseTime.month == timeSort.month &&
              parseTime.year == timeSort.year &&
              x.statusCode == stCode) {
            ReceiveWarrantyCardModel dt = new ReceiveWarrantyCardModel(
              statusName: x.statusName,
              statusCode: x.statusCode,
              content: x.content,
              createDate: x.createDate.toString(),
              phone: x.phone,
              address: x.address,
              codeWarranty: x.codeWarranty,
            );
            dataDateSort.add(dt);
          } else if (parseTime.day == timeSort.day &&
              parseTime.month == timeSort.month &&
              parseTime.year == timeSort.year &&
              stCode == -1) {
            ReceiveWarrantyCardModel dt = new ReceiveWarrantyCardModel(
              statusName: x.statusName,
              statusCode: x.statusCode,
              content: x.content,
              createDate: x.createDate.toString(),
              phone: x.phone,
              address: x.address,
              codeWarranty: x.codeWarranty,
            );
            dataDateSort.add(dt);
          }
          dataSort = dataDateSort;
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    statusRadio = -1;
    data = ReceiveWarrantyCardModel.RWCList;
    if (stCode == null) {
      stCode = -1;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 44, 195, 1),
        centerTitle: true,
        title: Text(
          'Danh Sách Phiếu',
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
            child: Row(
              children: [
                Text(
                  "Từ: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${selectedDateFrom.day.toString().padLeft(2, "0")}/${selectedDateFrom.month.toString().padLeft(2, "0")}/${selectedDateFrom.year.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _selectDateFrom(context);
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Đến: ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${selectedDateTo.day.toString().padLeft(2, "0")}/${selectedDateTo.month.toString().padLeft(2, "0")}/${selectedDateTo.year.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    _selectDateTo(context);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
            child: Row(
              children: [
                Text(
                  "Trạng Thái",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 250,
                  child: ListTile(
                    title: Text(
                      status ?? "Tất cả",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 44, 195, 1),
                      ),
                    ),
                    trailing: Icon(Icons.arrow_drop_down_outlined),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Container(
                                height: 300,
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                      return Container(
                                        height: 173,
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: dataStm.length,
                                          itemBuilder: (context, i) {
                                            return RadioListTile(
                                              title:
                                                  Text(dataStm[i].statusName),
                                              value: dataStm[i].statusCode,
                                              groupValue: statusRadio,
                                              onChanged: (val) => setState(() {
                                                statusRadio = val;
                                                stCode = statusRadio;
                                                status = dataStm[i].statusName;
                                              }),
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                            );
                                          },
                                        ),
                                      );
                                    }),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 120,
                                            child: ElevatedButton(
                                              child: Text('Đồng Ý'),
                                              style: TextButton.styleFrom(
                                                backgroundColor: Color.fromRGBO(
                                                    0, 44, 195, 1),
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                              ),
                                              onPressed: () {
                                                dateFilter();
                                                setState(() {});
                                                Navigator.pop(context);
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
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
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
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Color.fromRGBO(0, 44, 195, 1),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: 280,
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    decoration: new InputDecoration(
                      hintText: "Nhập thông tin để tìm kiếm",
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dataSort.length,
              itemBuilder: (context, i) {
                return listUI(dataSort[i], i);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listUI(ReceiveWarrantyCardModel rwc, i) {
    if (rwc.statusCode == 1) {
      statusBill = "Đã Tiếp Nhận";
      color = Colors.orangeAccent;
    } else if (rwc.statusCode == 2) {
      statusBill = "Đã Hoàn Tất";
      color = Colors.green;
    } else if (rwc.statusCode == 3) {
      statusBill = "Đã Hủy";
      color = Colors.red;
    }
    return Container(
      color: i % 2 == 0 ? Colors.black12 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.article_outlined,
              color: Color.fromRGBO(0, 44, 195, 1),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Mã Phiếu: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: rwc.codeWarranty,
                          style: new TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  width: 280,
                  child: RichText(
                    text: TextSpan(
                      text: 'Địa chỉ: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: rwc.address,
                            style:
                                new TextStyle(fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Ngày: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              '${DateFormat("dd/MM/yyyy").format(DateTime.parse(rwc.createDate.toString()))}',
                          style: new TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Nội Dung: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: rwc.content,
                          style: new TextStyle(fontWeight: FontWeight.normal)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Trang Thái: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: statusBill,
                          style: new TextStyle(
                              fontWeight: FontWeight.normal, color: color)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
