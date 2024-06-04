// import 'package:easy_audience_network/easy_audience_network.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdHelper {
//   static void init() {
//     EasyAudienceNetwork.init(
//       // testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6", //optional
//       testMode: true, // optional
//       iOSAdvertiserTrackingEnabled: true, //default false
//     );
//   }

//   static void showInterstitialAd(VoidCallback onComplete) {
//     // Get.back();
//     final interstitialAd = InterstitialAd(InterstitialAd.testPlacementId);
//     interstitialAd.listener = InterstitialAdListener(
//       onLoaded: () {
//         interstitialAd.show();
//         onComplete();
//       },
//       onDismissed: () {
//         interstitialAd.destroy();
//         print('Interstitial dismissed');
//       },
//       onError: (code, message) {
//         print("error : $code : $message");
//         onComplete();
//       },
//     );
//     interstitialAd.load();
//   }

//   static void nativeAd() {}
//   static void nativeBannerAd() {}
// }
