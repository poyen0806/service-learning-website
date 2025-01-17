import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/login_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SelectableText("登入", 
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold)
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 415,
              child: SelectableText("登入「中央資訊教育平台」以使用活動報名管理、線上課程系統、與其他更多功能服務。",
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(height: 60),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}