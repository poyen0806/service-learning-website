import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/widgets/user_icon/user_icon.dart';

class AppBarG extends StatelessWidget {
  const AppBarG({
    super.key,
    // required this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: const IconThemeData(
        color: Color(0xFF858585),
      ),
      title: Row(
        children: const [
          Icon(
            Icons.logo_dev,
            color: Color(0xFF474747),
          ),
          SizedBox(width: 3),
          Text(
            'ServiceSite_LOGO',
            style: TextStyle(
              color: Color(0xFF474747),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFffffff),
      pinned: false,
      elevation: 0,
      //floating: true,
      //forceElevated: innerBoxIsScrolled,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Builder(builder: (BuildContext context) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    context.push('/');
                  },
                  child: const Text(
                    "關於我們",
                    style: TextStyle(color: Color(0xFF474747), fontSize: 16),
                  ),
                );
              }),
              const SizedBox(
                width: 50,
              ),
              Builder(builder: (BuildContext context) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    context.push('/');
                  },
                  child: const Text(
                    "營隊活動",
                    style: TextStyle(color: Color(0xFF474747), fontSize: 16),
                  ),
                );
              }),
              const SizedBox(
                width: 50,
              ),
              Builder(builder: (BuildContext context) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    context.push('/');
                  },
                  child: const Text(
                    "教學文章",
                    style: TextStyle(color: Color(0xFF474747), fontSize: 16),
                  ),
                );
              }),
              const SizedBox(
                width: 50,
              ),
              Builder(builder: (BuildContext context) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    context.push("/${MyRouter.courses}");
                  },
                  child: const Text(
                    "線上課程",
                    style: TextStyle(color: Color(0xFF474747), fontSize: 16),
                  ),
                );
              }),
              const SizedBox(
                width: 50,
              ),
              Builder(builder: (BuildContext context) {
                return InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    context.push('/${MyRouter.test}'); // 借我放一下測試
                  },
                  child: const Text(
                    "Q&A",
                    style: TextStyle(color: Color(0xFF474747), fontSize: 16),
                  ),
                );
              }),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
              ),
              // Builder(builder: (BuildContext context) {
              //   return IconButton(
              //     onPressed: () {
              //       context.push('/favorites');
              //     },
              //     tooltip: 'Show Favourites',
              //     icon: Icon(Icons.favorite),color: Color(0xFF858585),);
              // }),
              // SizedBox(width: 10),
              const UserIcon(size: 36),
              const SizedBox(width: 10),
              // Icon(Icons.more_vert),
            ],
          ),
        ),
      ],
    );
  }
}
