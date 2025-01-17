import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/pages/admin_page/admin_page_courses.dart';
import 'package:service_learning_website/pages/admin_page/admin_page_users.dart';
import 'package:service_learning_website/pages/page_skeleton.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/test/window_size.dart';
import 'package:service_learning_website/widgets/side_menu.dart';
import 'package:service_learning_website/widgets/title_text_box.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<String> _items = ["營隊管理", "文章管理", "課程管理", "使用者管理", "常見問題", "表單回覆"];

  int _selectedIndex = 0;
  Widget _showingWidget = const SizedBox(height: 2000, child: Placeholder());

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if ((authProvider.userData?.permission ?? UserPermission.none) <
        UserPermission.student) {
      return const Scaffold(body: Center(child: Text("Permission denied")));
    }

    switch (_selectedIndex) {
      case 0:
        _showingWidget = Container(height: 2000, color: Colors.red);
        break;
      case 1:
        _showingWidget = Container(height: 2000, color: Colors.orange);
        break;
      case 2:
        _showingWidget = const AdminPageCourses();
        break;
      case 3:
        _showingWidget = const AdminPageUsers();
        break;
      case 4:
        _showingWidget = Container(height: 2000, color: Colors.blue);
        break;
      case 5:
        _showingWidget = Container(height: 2000, color: Colors.purple);
        break;
    }

    return PageSkeleton(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleTextBox("管理者後台"),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SideMenu(
                width: 260,
                items: _items,
                onDestinationSelected: (index) =>
                    setState(() => _selectedIndex = index),
              ),
              const SizedBox(width: 100),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _items[_selectedIndex],
                      style: const TextStyle(
                        fontSize: 48,
                        height: 58 / 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _showingWidget,
                    // Flexible(child: _showingWidget),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      bottomSheet: const WindowSize(),
    );
  }
}
