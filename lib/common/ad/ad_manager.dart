import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_constants.dart';

class AdManager with WidgetsBindingObserver {

  static Future<NativeAd?> loadNativeAdPurely({String? adUnitId}) async {
    Completer<Ad?> completer = Completer();
    var nativeAd = NativeAd(
        adUnitId: adUnitId ?? AdConstants.nativeAdUnitId,
        factoryId: "WonderlandNativeAdFactory",
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            completer.complete(ad);
          },
          onAdFailedToLoad: (ad, error) {
            //ad.dispose();
            completer.complete(null);
            ad.dispose();
          },
          // Called when a click is recorded for a NativeAd.
          onAdClicked: (ad) {},
          // Called when an impression occurs on the ad.
          onAdImpression: (ad) {},
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (ad) {},
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (ad) {},
          // For iOS only. Called before dismissing a full screen view
          onAdWillDismissScreen: (ad) {},
          // Called when an ad receives revenue value.
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: AdRequest());
    await nativeAd.load();
    var ad = await completer.future;
    if (ad != null) {
      return nativeAd;
    } else {
      return null;
    }
  }


}
