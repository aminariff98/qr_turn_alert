import 'package:flutter/material.dart';
import 'package:qr_turn_alert/main.dart';
import 'package:qr_turn_alert/views/widgets/app-nav-bar.dart';

class PromotionDisplay extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String referralCode;

  const PromotionDisplay({Key? key, required this.imageUrl, required this.title, required this.description, required this.referralCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppNavBarFlat(
          title: 'Promotion : $title',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Hero(tag: imageUrl, child: Image.network(imageUrl))),
            SizedBox(
              height: userScreenPadding,
            ),
            Padding(
              padding: EdgeInsets.only(left: userScreenPadding / 2, right: userScreenPadding),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6!.apply(fontSizeDelta: userTextSize),
              ),
            ),
            SizedBox(
              height: userScreenPadding / 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: userScreenPadding, right: userScreenPadding),
              child: Text(
                description,
                style: Theme.of(context).textTheme.bodyText1!.apply(fontSizeDelta: userTextSize),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: (referralCode != '')
          ? SafeArea(
              child: Padding(
              padding: EdgeInsets.only(bottom: userScreenPadding),
              child: Text(
                'Promo Code : ' + referralCode,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.apply(fontSizeDelta: userTextSize),
              ),
            ))
          : Container(
              height: 0,
            ),
    );
  }
}
