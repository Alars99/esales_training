import 'package:equatable/equatable.dart';
import 'package:esales_training/models/bill.dart';

class BillState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BillStateInitial extends BillState {}

class BillStateFailure extends BillState {}

class BillStateSuccess extends BillState {
  List<Bill> bills;
  @override
  // TODO: implement props
  List<Object> get props => [bills];
  BillStateSuccess(this.bills);
}
