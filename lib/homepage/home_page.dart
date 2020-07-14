// Importing the Pakages
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  List allSlides = [
    {'slideName': 'Home', 'selected': false, 'color': 200},
    {'slideName': 'About Us', 'selected': false, 'color': 400},
    {'slideName': 'Contact Us', 'selected': false, 'color': 600},
  ];
  var selectedSlide;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(changeSelector);
    setState(() {
      selectedSlide = allSlides[0];
      selectedSlide['selected'] = true;
    });
  }

  changeSelector() {
    var maxScrollValue = _scrollController.position.maxScrollExtent - 10;
    var divisor = (maxScrollValue / allSlides.length).round() + 200;
    // print(divisor);
    var scrollValue = _scrollController.offset.round();
    // print(scrollValue);
    var slideValue = (scrollValue / divisor).round();
    var currentSlide = allSlides.indexWhere((slide) => slide['selected']);
    setState(() {
      allSlides[currentSlide]['selected'] = false;
      selectedSlide = allSlides[slideValue];
      selectedSlide['selected'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Scroll Controller"),
        centerTitle: true,
      ),
      body: Stack(
        // fit: StackFit.expand,
        children: <Widget>[
          ListView(
            controller: _scrollController,
            children: allSlides.map((element) {
              return getContainer(element);
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              height: 50.0,
              color: Colors.deepOrange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: allSlides.map((element) {
                  return getTitles(element);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function returns container
  Widget getContainer(slide) {
    return Container(
      color: Colors.orange[slide['color']],
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Text(slide['slideName']),
      ),
    );
  }

  scrollToSlide(inputSlide) {
    var whichSlide = allSlides
        .indexWhere((slide) => slide['slideName'] == inputSlide['slideName']);
    var maxScrollValue = _scrollController.position.maxScrollExtent - 10;
    var divisor = (maxScrollValue / allSlides.length) + 200;
    var scrollToValue = whichSlide * divisor;
    // _scrollController.jumpTo(scrollToValue);
    _scrollController.animateTo(
      scrollToValue,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeIn,
    );
  }

  // Function Returns titles
  Widget getTitles(slide) {
    return InkWell(
      onTap: () {
        scrollToSlide(slide);
      },
      child: Text(
        slide['slideName'],
        style: TextStyle(
          fontWeight: slide['selected'] ? FontWeight.bold : FontWeight.normal,
          fontSize: slide['selected'] ? 20.0 : 16.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
