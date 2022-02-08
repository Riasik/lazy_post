import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OneSlide{
  final String name;
  final String img;
  OneSlide(this.name, this.img);
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  final Function(int)? onChangedIcon;
  final int current;
  CarouselWithIndicatorDemo({required this.onChangedIcon, required this.current});
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  final CarouselController _controller = CarouselController();
  late int _current;
  static const List<String> nameList = [
  '0,5 кг',
  '0,5 кг (плоская)',
  'для ноутбука',
  '1 кг',
  '1 кг (плоская)',
  '2 кг',
  '3 кг',
  '5 кг',
  '10 кг',
  '20 кг',
  '30 кг',
];

final List<OneSlide> imgList = [
  OneSlide('0,5 кг', 'images/parcelnp/new_post_05kg.jpeg'),
  OneSlide('0,5 кг (плоская)', 'images/parcelnp/new_post_050.jpeg'),
  OneSlide('для ноутбука','images/parcelnp/new_post_book.jpeg'),
  OneSlide('1 кг','images/parcelnp/new_post_1.jpeg'),
  OneSlide('1 кг (плоская)','images/parcelnp/new_post_1kg.jpeg'),
  OneSlide('2 кг','images/parcelnp/new_post_2.jpeg'),
  OneSlide('3 кг','images/parcelnp/new_post_3.jpeg'),
  OneSlide('5 кг','images/parcelnp/new_post_5.jpeg'),
  OneSlide('10 кг','images/parcelnp/new_post_10.jpeg'),
  OneSlide('20 кг','images/parcelnp/new_post_20.jpeg'),
  OneSlide('30 кг','images/parcelnp/new_post_30.jpeg'),
];

  @override
  void initState() {
    _current = widget.current;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = imgList.map((item) => Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image(image: AssetImage(item.img), width: 600.0),
                //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),

    )).toList();
    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              initialPage: _current,
              autoPlay: false,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                try {
                  widget.onChangedIcon!(index);
                } catch (_) {}
              }),

        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: nameList
            .asMap()
            .entries
            .map((entry) => GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme
                      .of(context)
                      .brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          )
        ).toList(),
      ),
    ]);
  }
}