import 'package:engineer_app/constants/colors/colors.dart';
import 'package:engineer_app/data/api/geo_locator.dart';
import 'package:engineer_app/presentaion/widgets/text_form_field_widget.dart';
import 'package:engineer_app/presentaion/widgets/wide_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetLatLong extends StatefulWidget {
  TextEditingController address_location;
  GetLatLong({Key? key, required this.address_location}) : super(key: key);

  @override
  State<GetLatLong> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLatLong> {
  String current_location_url = "Tap to get your location";

  String locationMessage = 'Current Location of User';
  String long = '';
  String lat = '';
  bool is_ready = false;
  bool is_louding = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormFieldWidget(
          validator: (value) {
            if (value!.isEmpty) {
              return ("this field cannot be empty");
            }
          },
          hint_text: "tap below to get you location",
          text_edting_controller: widget.address_location,
          read_only: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidButton(
              is_louding: is_louding,
              size_of_text: 15.sp,
              text: "Get Location",
              width: MediaQuery.of(context).size.width / 2,
              color: MyColors.primary_color,
              splashColor: MyColors.Splash_color,
              onTap: () {
                setState(() {
                  is_louding = true;
                });
                GeoLocator().getCurrentLocation().then((value) {
                  setState(() {
                    lat = '${value.latitude}';
                    long = '${value.longitude}';
                    widget.address_location.text =
                        'https://maps.google.com/?q=$lat,$long';
                    is_louding = false;
                    is_ready = true;
                  });
                });
              },
            ),
            WidButton(
                size_of_text: 13.sp,
                width: MediaQuery.of(context).size.width / 3,
                text: "Open in Maps",
                color: is_ready ? MyColors.primary_color : Colors.grey,
                splashColor: MyColors.Splash_color,
                onTap: is_ready
                    ? () {
                        GeoLocator().getCurrentLocation().then((value) {
                          GeoLocator().openMap(lat, long);
                        });
                      }
                    : () {}),
          ],
        ),
      ],
    );
  }
}
