import 'package:flutter/material.dart';
import 'package:qr_turn_alert/main.dart';

class DropDownList extends StatelessWidget {
  final List items;
  final String selectedValue;
  final String title;

  DropDownList({required this.items, required this.title, required this.selectedValue});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(userScreenPadding, userScreenPadding, userScreenPadding, userScreenPadding / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(15.0),
                      topRight: const Radius.circular(15.0),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromRGBO(173, 31, 97, 1),
                        Color.fromRGBO(70, 0, 106, 1),
                      ],
                    ),
                  ),
                  child: ListTile(
                    enabled: false,
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    title: Center(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.white, fontSizeDelta: userTextSize),
                      ),
                    ),
                  ),
                ),
                // if (loadingStatus)
                //   ListTile(
                //     enabled: false,
                //     contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                //     title: Center(
                //       child: SpinKitRing(
                //         color: Color(0xFFAD1F61),
                //         size: 31.0,
                //         lineWidth: 5.0,
                //       ),
                //     ),
                //   ),
                Flexible(child: getBody()),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close),
          iconSize: 30.0 + userTextSize,
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget getBody() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[400],
        height: 0.3,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return getLists(context, index);
      },
    );
  }

  Widget getLists(context, index) {
    return ListTileTheme(
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: (items[index] == selectedValue)
          ? ListTile(
              title: Text(
                items[index],
                style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
              ),
              trailing: Icon(
                Icons.check,
                color: Colors.green,
                size: 24.0 + userTextSize,
              ),
              onTap: () {
                Navigator.pop(context, index);
              },
            )
          : ListTile(
              title: Text(
                items[index],
                style: Theme.of(context).textTheme.subtitle2!.apply(color: Color(0xff1C3664), fontSizeDelta: userTextSize),
              ),
              onTap: () {
                Navigator.pop(context, index);
              },
            ),
    );
  }
}
