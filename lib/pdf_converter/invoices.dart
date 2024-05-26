import 'package:engineer_app/pdf_converter/DetailPage.dart';
import 'package:engineer_app/data/model/invoise_model.dart';
import 'package:engineer_app/pdf_converter/DetailPage.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Units'),
    ),
    body: ListView(
      children: [
        ...invoices.map(
          (e) => ListTile(
            title: Text(e.title),
            subtitle: Text(e.EngName),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => DetailPage(invoice: e),
                ),
              );
            },
          ),
        )
      ],
    ),
  );
}
}

List <Invoice> invoices = [
  Invoice(
       'David Thomas',
       '123 Fake St\r\nBermuda Triangle',
       
       LineItem(Nr: 01, Code: 'W01', Photo: 'images\preview.jpg', Category: 'Category', Note: 'Note', Width: 100, Height: 20, Position: 'Kitchen', AreamM2: 10),
       
       'Unit Name'),
       Invoice(
       'David Thomas',
       '123 Fake St\r\nBermuda Triangle',
       
       LineItem(Nr: 01, Code: 'W01', Photo: 'images\preview.jpg', Category: 'Category', Note: 'Note', Width: 100, Height: 20, Position: 'Kitchen', AreamM2: 10),
       
       'Unit Name'),Invoice(
       'David Thomas',
       '123 Fake St\r\nBermuda Triangle',
       
       LineItem(Nr: 01, Code: 'W01', Photo: 'images\preview.jpg', Category: 'Category', Note: 'Note', Width: 100, Height: 20, Position: 'Kitchen', AreamM2: 10),
       
       'Unit Name'),Invoice(
       'David Thomas',
       '123 Fake St\r\nBermuda Triangle',
       
       LineItem(Nr: 01, Code: 'W01', Photo: 'images\preview.jpg', Category: 'Category', Note: 'Note', Width: 100, Height: 20, Position: 'Kitchen', AreamM2: 10),
       
       'Unit Name'),
       

];

