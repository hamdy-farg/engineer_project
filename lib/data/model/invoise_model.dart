class Invoice {
  final String EngName;
  final String address;
  final String title;
  final LineItem items;
  Invoice(this.EngName, this.address, this.items , this.title);
}

class LineItem {
  final int Nr;
  final String Code;
  final String Photo;
  final String Category;
  final String Note;
  final double Width;
  final double Height;
  final String Position;
  final double AreamM2;

  LineItem({required this.Nr, required this.Code, required this.Photo, required this.Category, required this.Note, required this.Width, required this.Height, required this.Position, required this.AreamM2});
  
}