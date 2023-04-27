import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 100,
      color: Color(0xFF102542),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text(
              "單位：國立中央大學資訊工程學系\n地址：(320317) 桃園市中壢區中大路300號\n聯絡電話：03-422-7151\nemail：ncu4500@ncu.edu.tw",style: TextStyle(color: Color(0xFFFFFFFF)),)),
      ),
    );
  }
}
