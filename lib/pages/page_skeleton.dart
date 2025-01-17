import 'package:flutter/material.dart';
import 'package:service_learning_website/widgets/app_bar_g.dart';
import 'package:service_learning_website/widgets/footer.dart';

class PageSkeleton extends StatelessWidget {
  const PageSkeleton({
    super.key,
    required this.body,
    this.navigationBar,
    this.footer,
    this.bottomSheet,
  });

  final Widget? navigationBar;
  final Widget body;
  final Widget? footer;
  final Widget? bottomSheet;

  @override
  Widget build(BuildContext context) {
    final windowHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [navigationBar ?? const AppBarG()],
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: windowHeight),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 100, right: 100, top: 60, bottom: 100),
                  child: body,
                ),
              ),
              footer ?? const Footer(),
            ],
          ),
        ),
      ),
      bottomSheet: bottomSheet,
    );
  }
}
