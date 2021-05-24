import 'package:esales_training/view/bill_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bill_bloc.dart';
import 'events/bill_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'eSales_Training',
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => BillBloc()..add(BillFetchedEvent()),
          child: BillList(),
        ));
  }
}
