import 'package:equatable/equatable.dart';

abstract class BillEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BillFetchedEvent extends BillEvent {}

class BillEventval extends BillEvent {
  DateTime selectedDateFrom;
  DateTime selectedDateTo;
  int statusCode;
  String status;
  BillEventval(
      this.selectedDateFrom, this.selectedDateTo, this.statusCode, this.status);
}
