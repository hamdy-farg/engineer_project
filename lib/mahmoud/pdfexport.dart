import 'dart:typed_data';
import 'package:engneers_app/data/model/invoise_model.dart';
import 'package:engneers_app/mahmoud/invoices.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Uint8List> makePdf(Invoice invoice) async {
  final imageLogo = MemoryImage((await rootBundle.load('images/channels4_profile.jpg')).buffer.asUint8List());
  final imageunit = MemoryImage((await rootBundle.load('images/AdobeStock_73538912-scaled.jpeg')).buffer.asUint8List());
  final pdf = Document();
  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a3,
    build: (context) {
      return Column(
        children: [
          Column(
  children: [
    Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
      children: [
        Text("Eng name: ${invoice.EngName}"),
        Text(invoice.address),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
    SizedBox(
      height: 150,
      width: 150,
      child: Image(imageLogo),
    ),
        ]
    ),
    Container(
      child: Table(
         border: TableBorder.all(color: PdfColors.black),
          tableWidth: TableWidth.max,
        children: [
           TableRow(
      children: [
        Expanded(
          child: PaddedText("Nr"),
          flex: 1,
        ),
        Expanded(
            child: PaddedText("Code"),
            flex: 1,
          ),
          Expanded(
            child: PaddedText("Photo"),
            flex: 2,
          ),
           Expanded(
            child: PaddedText("Category"),
            flex: 2,
          ),
           Expanded(
            child: Center( child:  PaddedText("Note"),),
            flex: 2,
          ), Expanded(
            child: PaddedText("Width"),
            flex: 1,
          ), Expanded(
            child: PaddedText("Height"),
            flex: 1,
          ),Expanded(
            child: PaddedText("Position"),
            flex: 2,
          ),Expanded(
            child: PaddedText("Area(m2)"),
            flex: 1,
          ),
      ],
    ),
        ]
        
      ),
    ),
    Container(
      padding: EdgeInsets.only(top: 0),
       child: Table(
  border: TableBorder.all(color: PdfColors.black),
  tableWidth: TableWidth.max,
  children: 
    
  List <TableRow> .generate(invoices.length, (index)  {
      return TableRow(
        children: [
          Expanded(
            child: PaddedText('${invoices[index].items.Nr}'),
            flex: 1,
          ),
          Expanded(
            child: PaddedText("${invoices[index].items.Code}"),
            flex: 1,
          ),
           Expanded(
            child:  Image(imageunit),
            flex: 1,
          ),Expanded(
            child:  Image(imageunit),
            flex: 1,
          ),
          Expanded(
            child: PaddedText("${invoices[index].items.Category}"),
            flex: 2,
          ),
          Expanded(
            child: PaddedText("${invoices[index].items.Note}"),
            flex: 2,
          ),Expanded(
            child: PaddedText("${invoices[index].items.Width}"),
            flex: 1,
          ),Expanded(
            child: PaddedText("${invoices[index].items.Height}"),
            flex: 1,
          ),Expanded(
            child: PaddedText("${invoices[index].items.Position}"),
            flex: 2,
          ),Expanded(
            child: PaddedText("${invoices[index].items.AreamM2}"),
            flex: 1,
          ),
        ],
  );
  }),

   // The first row just contains a phrase 'INVOICE FOR PAYMENT'
   
    // The remaining rows contain each item from the invoice, and uses the
    // map operat or (the ...) to include these items in the list
    

       ),
),
    
Padding(
  child: Text(
    "THANK YOU FOR YOUR HARD WORK",
    style: Theme.of(context).header2,
  ),
  padding: EdgeInsets.all(20),
),
          ],
),
        ],
    );
    }
    )
  );
  return pdf.save();
}

Widget PaddedText(
  final String text, {
  final TextAlign align = TextAlign.left,
}) =>
    Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
      ),
    );
     




     