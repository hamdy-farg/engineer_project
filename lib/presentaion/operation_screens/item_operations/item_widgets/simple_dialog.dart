import 'package:engineer_app/presentaion/widgets/utils_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    super.key,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  Uint8List? _file;
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await Pickimage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("open galery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await Pickimage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                  padding: EdgeInsets.all(20),
                  child: Text("close"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 1)),
      height: MediaQuery.of(context).size.height / 5.2,
      width: MediaQuery.of(context).size.width / 2.4,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () {
            _selectImage(context);
            setState(() {});
          },
          child: _file != null
              ? Image(
                  image: MemoryImage(_file!),
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.grey,
                    size: MediaQuery.of(context).size.height / 15,
                  ),
                ),
        ),
      ),
    );
  }
}
