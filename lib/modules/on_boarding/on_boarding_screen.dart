import 'package:flutter/material.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel({
    this.image,
    this.title,
    this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/onboard_1.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/onboard_1.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/onboard_1.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
    
  }

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            submit();
          }, child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  }else{
                    isLast = false;
                  } 
                },
                controller: boardController,
                itemBuilder: (context, index) => buildBoardingItem(
                  boarding[index],
                ),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                SmoothPageIndicator(
                controller: boardController,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                ),
                count: boarding.length,
                 ),
                 Spacer(),
                FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      }else {
                        boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                      }
                      
                    },
                    child: Icon(Icons.arrow_forward_ios))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage('${model.image}'), width: 500),
          ),
          Text('${model.title}',
              style: TextStyle(
                fontSize: 24,
              )),
          SizedBox(height: 30),
          Text('${model.body}',
              style: TextStyle(
                fontSize: 14,
              )),
        ],
      );
}
