import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/modules/backend/user_permission.dart';
import 'package:service_learning_website/modules/my_router.dart';
import 'package:service_learning_website/providers/auth_provider.dart';
import 'package:service_learning_website/providers/courses_provider.dart';

class CourseEditingPageChapters extends StatefulWidget {
  const CourseEditingPageChapters(
    this.courseId, {
    super.key,
  });

  final String courseId;

  @override
  State<CourseEditingPageChapters> createState() =>
      _CourseEditingPageChaptersState();
}

class _CourseEditingPageChaptersState extends State<CourseEditingPageChapters> {
  bool _canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, CoursesProvider>(
      builder: (context, authProvider, coursesProvider, child) {
        final courseData = coursesProvider.coursesData[widget.courseId]!;
        _canEdit = (authProvider.userData?.permission ?? UserPermission.none) >=
                UserPermission.ta ||
            courseData.members.contains(authProvider.userData?.uid);
        final chaptersList = courseData.chapters.values.toList();
        chaptersList.sort((a, b) => a.number.compareTo(b.number));

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_canEdit)
              ElevatedButton(
                onPressed: () => coursesProvider.createChapter(widget.courseId),
                child: const Text("新增章節"),
              ),
            if (_canEdit) const SizedBox(height: 40),
            DataTable(columns: [
              const DataColumn(label: Text("編號")),
              const DataColumn(label: Text("標題")),
              const DataColumn(label: Text("瀏覽／編輯")),
              if (_canEdit) const DataColumn(label: Text("移動順序")),
            ], rows: [
              for (int i = 0; i < chaptersList.length; i++)
                DataRow(cells: [
                  DataCell(SelectableText("${chaptersList[i].number + 1}")),
                  DataCell(SelectableText(chaptersList[i].title)),
                  DataCell(IconButton(
                    onPressed: () => context.push(
                        "/${MyRouter.admin}/${MyRouter.courses}/${widget.courseId}/${chaptersList[i].id}"),
                    icon: _canEdit
                        ? const Icon(Icons.edit)
                        : const Icon(Icons.visibility),
                  )),
                  if (_canEdit)
                    DataCell(Row(children: [
                      IconButton(
                          disabledColor: Colors.grey,
                          onPressed: i == 0
                              ? null
                              : () {
                                  setState(() {
                                    chaptersList[i].number--;
                                    chaptersList[i - 1].number++;
                                  });
                                  coursesProvider.updateChapter(
                                      widget.courseId, chaptersList[i].id);
                                  coursesProvider.updateChapter(
                                      widget.courseId, chaptersList[i - 1].id);
                                },
                          icon: const Icon(Icons.arrow_upward)),
                      IconButton(
                          disabledColor: Colors.grey,
                          onPressed: i == chaptersList.length - 1
                              ? null
                              : () {
                                  setState(() {
                                    chaptersList[i].number++;
                                    chaptersList[i + 1].number--;
                                  });
                                  coursesProvider.updateChapter(
                                      widget.courseId, chaptersList[i].id);
                                  coursesProvider.updateChapter(
                                      widget.courseId, chaptersList[i + 1].id);
                                },
                          icon: const Icon(Icons.arrow_downward)),
                    ])),
                ]),
            ])
          ],
        );
      },
    );
  }
}
