// ignore: must_be_immutable
class Bill {
  String codeWarranty;
  String address;
  String phone;
  int statusCode;
  String statusName;
  String createDate;
  String content;

  Bill({
    this.codeWarranty,
    this.address,
    this.phone,
    this.statusCode,
    this.statusName,
    this.createDate,
    this.content,
  });

  static List<Bill> RWCList = <Bill>[
    Bill(
      codeWarranty: "#TP23214322432431",
      address:
          "11bb 72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 1,
      statusName: "abc",
      createDate: "2021-05-19 00:00:00.000",
      content: "Kiểm tra nguồn không lên 11aa",
    ),
    Bill(
      codeWarranty: "#TP23214322432766",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 3,
      statusName: "abc",
      createDate: "2021-05-19 00:00:00.000",
      content: "Kiểm tra nguồn không lên 11aa",
    ),
    Bill(
      codeWarranty: "#TP23214322432776",
      address:
          "11 bb 72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 2,
      statusName: "abc",
      createDate: "2021-05-19 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP2321432243299090",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 1,
      statusName: "abc",
      createDate: "2021-05-20 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP2321432243219090",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 2,
      statusName: "abc",
      createDate: "2021-05-20 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP23214322432111",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 1,
      statusName: "abc",
      createDate: "2021-05-20 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP23214322432111",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 3,
      statusName: "abc",
      createDate: "2021-05-03 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP23214322432111",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 2,
      statusName: "abc",
      createDate: "2021-05-26 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP23214322432111",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 3,
      statusName: "abc",
      createDate: "2021-05-31 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
    Bill(
      codeWarranty: "#TP23214322432111",
      address:
          "72/24 Phan Đăng Lưu, Phường 5, Q.Phú Nhuận, Tp.Hồ Chí Minh",
      phone: "0902874982",
      statusCode: 1,
      statusName: "abc",
      createDate: "2021-05-29 00:00:00.000",
      content: "Kiểm tra nguồn không lên",
    ),
  ];
}
