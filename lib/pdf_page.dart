


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_page/title_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';



import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'PdfInvoiceApi.dart';
import 'button_widget.dart';
import 'main.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(MyApp.title),

          ),
          body: Container(
              padding: EdgeInsets.all(32),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TitleWidget(
                          icon: Icons.picture_as_pdf,
                          text: 'Generate Invoice',
                        ),
                        const SizedBox(height: 48),
                        ButtonWidget(
                            text: 'Invoice PDF',
                            onClicked: () async {
                              final date = DateTime.now();
                              final dueDate = date.add(Duration(days: 7));

                              final _createPDF = Invoice(
                                supplier: Supplier(
                                  name: 'Sarah Field',
                                  address: 'Sarah Street 9, Beijing, China',
                                  // paymentInfo: 'https://paypal.me/sarahfieldzz',
                                ),
                                customer: Customer(
                                  name: 'Apple Inc.',
                                  address: 'Apple Street, Cupertino, CA 95014',
                                ),
                                info: InvoiceInfo(
                                  date: date,
                                  dueDate: dueDate,
                                  description: 'My description...',
                                  number: '${DateTime
                                      .now()
                                      .year}-9999',
                                ),
                                items: [
                                  InvoiceItem(
                                    description: 'Coffee',
                                    date: DateTime.now(),
                                    quantity: 3,
                                    vat: 0.19,
                                    unitPrice: 5.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Water',
                                    date: DateTime.now(),
                                    quantity: 8,
                                    vat: 0.19,
                                    unitPrice: 0.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Orange',
                                    date: DateTime.now(),
                                    quantity: 3,
                                    vat: 0.19,
                                    unitPrice: 2.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Apple',
                                    date: DateTime.now(),
                                    quantity: 8,
                                    vat: 0.19,
                                    unitPrice: 3.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Mango',
                                    date: DateTime.now(),
                                    quantity: 1,
                                    vat: 0.19,
                                    unitPrice: 1.59,
                                  ),
                                  InvoiceItem(
                                    description: 'Blue Berries',
                                    date: DateTime.now(),
                                    quantity: 5,
                                    vat: 0.19,
                                    unitPrice: 0.99,
                                  ),
                                  InvoiceItem(
                                    description: 'Lemon',
                                    date: DateTime.now(),
                                    quantity: 4,
                                    vat: 0.19,
                                    unitPrice: 1.29,
                                  ),
                                ],
                              );
                              final pdfFile = await PdfInvoiceApi.generate(
                                  _createPDF);
                              //  final pdfFile2 = await PdfInvoiceApi.generate(invoice);
                              PdfApi.openFile(pdfFile);
                            }

                        )

                      ]
                  )
              )
          )
      );
}


class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}



class Customer {
  final String name;
  final String address;

  const Customer({
    required this.name,
    required this.address,
  });
}

class Supplier {
  final String name;
  final String address;


  const Supplier({
    required this.name,
    required this.address,

  });
}


class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String description;
  final DateTime date;
  final int quantity;
  final double vat;
  final double unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}

