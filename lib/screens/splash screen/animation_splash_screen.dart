

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mobile/constants/colors.dart';
import 'package:project_mobile/constants/sizes.dart';
import '../../common_widgets/fade in animation/animation_design.dart';
import '../../common_widgets/fade in animation/fade_in_animation_controller.dart';
import '../../common_widgets/fade in animation/fade_in_animation_model.dart';
import '../../constants/image_string.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(194, 193, 225, 1.0),
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1000,
            animate: TAnimatePosition(
              topAfter: 190, 
              topBefore: 190, 
              // rightAfter: tDefaultSize, 
              rightBefore: -20,
            ),
            child:Image(image: const AssetImage(tSplashBg), height: height * 0.6),
          ),
          TFadeInAnimation(
            durationInMs: 2000,
            animate: TAnimatePosition(
              topAfter: 130, 
              topBefore: 130, 
              leftBefore: -90, 
              leftAfter: tDefaultSize,
            ),
            child:Image(image: const AssetImage(tSplashTopIcon), height: height * 0.1),
          ),
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              bottomBefore: 0, 
              bottomAfter: 90,
              leftAfter: 150,
              leftBefore: 150,
            ),
            child: Image(image: const AssetImage(tSplashImage), height: height * 0.35),
          ),
          TFadeInAnimation(
            durationInMs: 2400,
            animate: TAnimatePosition(
              bottomBefore: 0, 
              bottomAfter: 60, 
              rightBefore: tDefaultSize, 
              rightAfter: tDefaultSize
            ),
            child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tPrimaryColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
