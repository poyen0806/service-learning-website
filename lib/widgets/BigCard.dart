import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BigCard extends StatelessWidget {
  BigCard({
    super.key,
    required this.card,
  });

  final WordPair card;
  var rndS = ['This is a ','Such a ','What a '];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: Color(0xFF1f1f1f),
    );

    return Card(
      color: Color(0xFFadadad),
      elevation: 0,
      shadowColor: Color(0xFF151515),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
        child: Text(
          card.first.toLowerCase()+' '+card.second.toLowerCase(),
          style: style,
          semanticsLabel: "${card.first} ${card.second}",
        ),
      ),
    );
  }
}