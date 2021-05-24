import 'package:esales_training/events/bill_event.dart';
import 'package:esales_training/states/bill_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../globals.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillStateInitial());

  @override
  Stream<BillState> mapEventToState(BillEvent event) async* {
    if (event is BillEventval) {
      if (stCode != -1) {
        dataSort = data
            .where((e) =>
                DateTime.parse(e.createDate).isAfter(event.selectedDateFrom) &&
                DateTime.parse(e.createDate).isBefore(event.selectedDateTo) &&
                e.statusCode == stCode)
            .toList();
        dataSort.sort((a, b) => DateTime.parse(b.createDate)
            .compareTo(DateTime.parse(a.createDate)));
        emptysearch = dataSort;
        yield BillStateSuccess(dataSort);
      } else {
        dataSort = data
            .where((e) =>
                DateTime.parse(e.createDate).isAfter(event.selectedDateFrom) &&
                DateTime.parse(e.createDate).isBefore(event.selectedDateTo))
            .toList();
        dataSort.sort((a, b) => DateTime.parse(b.createDate)
            .compareTo(DateTime.parse(a.createDate)));
        yield BillStateSuccess(dataSort);
      }
    }
  }
}
