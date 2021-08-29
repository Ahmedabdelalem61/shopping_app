import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'file:///E:/api%20news%20app/TODO-main/lib/modules/shop_app/login/login_screen.dart';
import 'package:task_todo/shared/components/news_component.dart';
import 'package:task_todo/shared/network/local/cashe_helper.dart';

class BoardingModel {
  String image;

  String title;

  String body;

  BoardingModel(
      {@required this.image, @required this.title, @required this.body});
}

class OnBordingScreen extends StatefulWidget {
  @override
  _OnBordingScreenState createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  List<BoardingModel> model = [
    BoardingModel(
        image: 'assets/images/onboarding.png',
        title: 'boarding screen',
        body: 'this is body'),
    BoardingModel(
        image: 'assets/images/onboarding.png',
        title: 'boarding screen',
        body: 'this is body 2'),
    BoardingModel(
        image: 'assets/images/onboarding.png',
        title: 'boarding screen',
        body: 'this is body 3'),
  ];

  PageController pageController = PageController();

  bool islast = false;
  void submit(){
    CasheHelper.saveData(key: 'onBoarding',value: true).then((value) {
      if(value){
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: Text(
                'skip',
                style: TextStyle(color: Colors.deepOrange),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (int index) {
                if (index == model.length - 1) {
                  setState(() {
                    islast = true;
                  });
                } else {
                  setState(() {
                    islast = false;
                  });
                }
              },
              controller: pageController,
              itemBuilder: (context, index) => BuildBoardingItem(model[index]),
              physics: BouncingScrollPhysics(),
              itemCount: model.length,
            )),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: model.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Colors.deepOrange,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 10,
                      strokeWidth: 20),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.keyboard_arrow_right_rounded),
                  backgroundColor: Colors.deepOrange,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(modl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(modl.image),
          fit: BoxFit.fill,
        )),
        SizedBox(
          height: 40,
        ),
        Text(
          modl.title,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Text(modl.body,
            style: TextStyle(
              fontSize: 14,
            )),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
