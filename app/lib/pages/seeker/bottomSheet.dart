// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:app/shared/globals.dart';
import 'package:app/shared/globals.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ModalImage extends StatefulWidget {
  final List<dynamic> image;
  const ModalImage(this.image);

  @override
  _ModalImageState createState() => _ModalImageState();
}

class _ModalImageState extends State<ModalImage> {
  // bool isCurrentlyTouching = false;

  @override
  void initState() {
    print('imagechecking : ');
    print(this.widget.image);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.image.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 1.0),
        MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          focusColor: Global.theme4,
          height: 5,
          minWidth: size.width * 0.2,
          color: Colors.grey[200],
          onPressed: () {
            setState(() {
              // isCurrentlyTouching = !isCurrentlyTouching;
            });
          },
        ),
        SizedBox(height: 5),
        Expanded(
          child: CarouselSlider.builder(
            itemCount: widget.image.length,
            options: CarouselOptions(
              enableInfiniteScroll: false,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              enlargeCenterPage: true,
            ),
            itemBuilder: (context, index, realIdx) {
              return Container(
                child: Center(
                    child: Image.network(widget.image[index],
                        fit: BoxFit.fill, width: size.width)),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.image.map((url) {
            int index = widget.image.indexOf(url);
            return Container(
              width: 8.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
