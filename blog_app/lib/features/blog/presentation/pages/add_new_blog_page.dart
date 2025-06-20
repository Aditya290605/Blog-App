import 'dart:io';

import 'package:blog_app/core/theme/app_colors.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/text_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});
  route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  List<String> selectedItems = [];

  void selectImage() async {
    final res = await PickImage().pickImage(ImageSource.gallery);
    setState(() {
      if (res == null) {
        return;
      }
      file = File(res.path);
    });
  }

  final TextEditingController blog = TextEditingController();

  final TextEditingController blogContent = TextEditingController();
  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Icon(Icons.done_rounded)]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              file == null
                  ? GestureDetector(
                    onTap: selectImage,
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: Radius.circular(14),
                        color: Colors.grey,
                        dashPattern: [12, 8],
                      ),
                      child: Container(
                        height: 150,
                        width: double.infinity,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 40),
                            const SizedBox(height: 20),
                            Text(
                              "Select your image",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : GestureDetector(
                    onTap: selectImage,
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(file!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
              const SizedBox(height: 40),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      {'Busniess', 'Technology', 'Programming', 'Entertainment'}
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedItems.contains(e)) {
                                    selectedItems.remove(e);
                                  } else {
                                    selectedItems.add(e);
                                  }
                                  setState(() {});
                                },
                                child: Chip(
                                  side:
                                      selectedItems.contains(e)
                                          ? BorderSide.none
                                          : BorderSide(
                                            color: AppPallete.borderColor,
                                          ),
                                  color: WidgetStatePropertyAll(
                                    selectedItems.contains(e)
                                        ? AppPallete.gradient1
                                        : AppPallete.backgroundColor,
                                  ),
                                  label: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),

              const SizedBox(height: 20),

              TextEditor(hintTex: 'Blog title', controller: blog),
              const SizedBox(height: 15),
              TextEditor(hintTex: 'Blog Content', controller: blogContent),
            ],
          ),
        ),
      ),
    );
  }
}
