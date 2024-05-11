
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_manager.dart';

class AdCardView extends StatefulWidget {
  final String? adUnitId;

  AdCardView({super.key,this.adUnitId});

  @override
  State<StatefulWidget> createState() {
    return _AdCardViewState();
  }
}

class _AdCardViewState extends State<AdCardView> {
  NativeAd? _ad;
  bool adLoaded = false;
  bool hide = false;

  ValueNotifier<bool> showDontLikeNotifier = ValueNotifier(false);
  ValueNotifier<bool> hideNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    loadNewAd();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, cons) {
      if (hide) {
        return SizedBox();
      }
      if (_ad != null && adLoaded) {
        return Stack(
          children: [
            GestureDetector(
              onLongPress: () {
                showDontLikeNotifier.value = true;
              },
              child: Container(
                width: cons.maxWidth,
                height: 270,
                alignment: Alignment.center,
                child: AdWidget(
                  ad: _ad!,
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: showDontLikeNotifier,
                builder: (context, value, widget) {
                  if(value) {
                    return InkWell(
                      onTap: (){
                        showDontLikeNotifier.value = false;
                      },
                      child: Container(
                        width: cons.maxWidth,
                        height: 270,
                        decoration: BoxDecoration(
                            color: Color(0x9a000000),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  hide = true;
                                });
                              },
                              child: Container(
                                width: 134,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 12.5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Color(0xFF2C75DD)),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Text(
                                  "Don’t like",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "sans-serif",
                                      color: Color(0xFF2C75DD)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return SizedBox();
                  }
                })
          ],
        );
      } else {
        return Container(
          color: Colors.transparent,
          width: cons.maxWidth,
          height: 270,
        );
      }
    });
  }

  void loadNewAd() async {
    if (hide) {
      return;
    }
    _ad = await AdManager.loadNativeAdPurely(adUnitId: widget.adUnitId);
    setState(() {
      adLoaded = _ad != null;
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

}