import 'package:flutter/material.dart';

import 'ad_card_view.dart';


class TestNativeAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestNativeAdPageState();
  }
}

class _TestNativeAdPageState extends State<TestNativeAdPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AdCardView(),
        ],
      ),
    );
  }
}
