package com.construct.alice.multiple.flutter.plugin

import android.app.Activity
import android.view.LayoutInflater
import androidx.core.view.isVisible
import com.construct.alice.flutter_ad_test.databinding.ViewWonderlandNativeAdBinding
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class WonderlandNativeAdFactory(val activity: Activity) : NativeAdFactory {

    private val vb: ViewWonderlandNativeAdBinding = ViewWonderlandNativeAdBinding.inflate(LayoutInflater.from(activity))

    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView {
        vb.adMedia.apply {
            mediaContent = nativeAd.mediaContent
        }
        vb.root.mediaView = vb.adMedia
        vb.root.headlineView = vb.adHeadline
        vb.root.callToActionView = vb.adCallToAction
        vb.root.iconView = vb.adAppIcon
        vb.root.advertiserView = vb.adAdvertiser
        if (nativeAd.headline == null) {
            vb.adHeadline.isVisible = false
        } else {
            vb.adHeadline.text = nativeAd.headline
            vb.adHeadline.isVisible = true
        }
        if (nativeAd.icon == null) {
            vb.adAppIcon.isVisible = false
        } else {
            vb.adAppIcon.isVisible = true
            vb.adAppIcon.setImageDrawable(nativeAd.icon!!.drawable)
        }
        if (nativeAd.callToAction == null) {
            vb.adCallToAction.isVisible = false
        } else {
            vb.adCallToAction.isVisible = true
            vb.adCallToAction.text = nativeAd.callToAction
        }
        vb.root.setNativeAd(nativeAd)
        return vb.root
    }
}