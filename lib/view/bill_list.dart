import 'dart:ui';

import 'package:esales_training/blocs/bill_bloc.dart';
import 'package:esales_training/events/bill_event.dart';
import 'package:esales_training/globals.dart';
import 'package:esales_training/models/StatusModel.dart';
import 'package:esales_training/models/bill.dart';
import 'package:esales_training/states/bill_state.dart';
import 'package:esales_training/view/status_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BillList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BillListState();
}

class _BillListState extends State<BillList> {
  final _scrollController = ScrollController();

  String statusBill;
  Color color;

  int lengthDays;

  int _scrollThreadhold = 250;

  TextEditingController controller = new TextEditingController();

  StatusModel stm;
  List<StatusModel> dataStm = StatusModel.statusList;

  DateTime pickedFrom;
  DateTime pickedTo;
  DateTime timeSort;
  DateTime parseTime;

  Bill bill;
  BillBloc _billBloc;

  DateTime selectedDateFrom = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day - 31);
  DateTime selectedDateTo = DateTime.now();

  @override
  void initState() {
    super.initState();
    _billBloc = BlocProvider.of(context);

    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        _billBloc.add(BillFetchedEvent());
      }
    });

    data = emptysearch;

    if (stCode == null) {
      stCode = -1;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
      body: SafeArea(
        child: Column(
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
                    onPressed: () async {
                      await _selectDateFrom();
                      context.read<BillBloc>().add(BillFetchedEvent());
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
                    onPressed: () async {
                      await _selectDateTo();
                      context.read<BillBloc>().add(BillFetchedEvent());
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
                              return StatusDialog(context, (val) {
                                setState(() {
                                  status = val;
                                  print(status);
                                });
                              });
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
                    child: TextField(
                      controller: controller,
                      cursorColor: Colors.grey,
                      decoration: new InputDecoration(
                        hintText: "Nhập thông tin để tìm kiếm",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      onChanged: onSearchTextChanged,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<BillBloc, BillState>(
              builder: (context, state) {
                context.read<BillBloc>().add(BillEventval(
                    selectedDateFrom, selectedDateTo, stCode, statusBill));
                if (state is BillStateInitial) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is BillStateFailure) {
                  return Center(
                    child: Text(
                      'Không thể tải dữ liệu từ máy chủ',
                      style: TextStyle(fontSize: 22, color: Colors.red),
                    ),
                  );
                }
                if (state is BillStateSuccess) {
                  if (state.bills.isEmpty) {
                    return Center(child: Text('Không có phiếu!'));
                  }
                  return Flexible(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext buildContext, i) {
                          return listUI(state.bills[i], i);
                        },
                        itemCount: state.bills.length,
                        //add more item
                        controller: _scrollController),
                  );
                }
                return Center(child: Text('Empty'));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget listUI(Bill bill, i) {
    if (bill.statusCode == 1) {
      statusBill = "Đã Tiếp Nhận";
      color = Colors.orangeAccent;
    } else if (bill.statusCode == 2) {
      statusBill = "Đã Hoàn Tất";
      color = Colors.green;
    } else if (bill.statusCode == 3) {
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
                          text: bill.codeWarranty,
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
                            text: bill.address,
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
                              '${DateFormat("dd/MM/yyyy").format(DateTime.parse(bill.createDate.toString()))}',
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
                          text: bill.content,
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

  _selectDateFrom() async {
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
      });
  }

  _selectDateTo() async {
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
      });
  }

  onSearchTextChanged(text) async {
    List<Bill> result = [];
    setState(() {
      if (text.isEmpty) {
        emptysearch = data2;
        result = emptysearch;
        data = data2;
      } else {
        result = emptysearch
            .where((e) =>
                e.codeWarranty.toLowerCase().contains(text.toLowerCase()) ||
                e.address.toLowerCase().contains(text.toLowerCase()) ||
                e.content.toLowerCase().contains(text.toLowerCase()))
            .toList();
        data = result;
      }
    });
  }
}
