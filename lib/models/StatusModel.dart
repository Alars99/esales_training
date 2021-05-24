class StatusModel {
  int statusCode;
  String statusName;
  bool isSelected;

  StatusModel({this.statusCode, this.statusName, this.isSelected});

  static List<StatusModel> statusList = <StatusModel>[
    StatusModel(statusCode: -1, statusName: "Tất cả", isSelected: false),
    StatusModel(statusCode: 1, statusName: "Đã Tiếp Nhận", isSelected: false),
    StatusModel(statusCode: 2, statusName: "Đã Hoàn Tất", isSelected: false),
    StatusModel(statusCode: 3, statusName: "Đã Hủy", isSelected: false),
  ];
}
