import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:mobile_abz/presentation/widgets/Icons.dart';
import 'package:mobile_abz/presentation/widgets/layouts.dart';
import 'package:url_launcher/url_launcher.dart';

class PostTemplate extends StatefulWidget {
  final dynamic content;
  const PostTemplate({super.key, required this.content});

  @override
  State<PostTemplate> createState() => _PostTemplateState();
}

class _PostTemplateState extends State<PostTemplate> {
  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Не удалось открыть ссылку: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> gallery = [];
    if (widget.content != null && widget.content is Map) {
      gallery = (widget.content['acf']?['gallery'] as List<dynamic>?) ?? [];
    }
    String description = widget.content?['acf']?['description'] ?? '';
    return Layouts(currentIndex: 1, slivers: [
      SliverToBoxAdapter(
          child: Animate(
        effects: [FadeEffect()],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                child: const IconWidget(
                                  iconName: 'arrow-left',
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (widget.content?['title'] != null)
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 300),
                                  child: Text(
                                    widget.content['title'] ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              if (gallery.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 318,
                        child: Swiper(
                          itemCount: gallery.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Container(
                                child: Image.network(
                                  gallery[index]['img'],
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                              ),
                            );
                          },
                          pagination: SwiperCustomPagination(
                            builder: (BuildContext context,
                                SwiperPluginConfig config) {
                              return Positioned(
                                bottom: 16,
                                left: 16,
                                right: 16,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final double totalWidth =
                                        constraints.maxWidth;
                                    const double spacing = 8.0;
                                    final int itemsCount = gallery.length;

                                    final double inactiveWidth = (totalWidth -
                                            spacing * (itemsCount - 1)) /
                                        (itemsCount + 1);

                                    final double activeWidth =
                                        inactiveWidth * 2;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        itemsCount,
                                        (index) {
                                          final isActive =
                                              index == config.activeIndex;
                                          return AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            width: isActive
                                                ? activeWidth
                                                : inactiveWidth,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: isActive
                                                  ? Colors.white
                                                  : Colors.white
                                                      .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            margin: EdgeInsets.only(
                                                right: index < itemsCount - 1
                                                    ? spacing
                                                    : 0),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Html(
                data: description,
                style: {
                  "p": Style(
                      fontSize: FontSize.medium,
                      lineHeight: LineHeight.number(1.5)),
                  "h1": Style(
                      fontSize: FontSize.xLarge, fontWeight: FontWeight.bold),
                  "h2": Style(
                      fontSize: FontSize.large, fontWeight: FontWeight.bold),
                  "ul": Style(),
                  "li": Style(),
                },
                extensions: [
                  TagExtension(
                    tagsToExtend: {"img"},
                    builder: (context) {
                      final attrs = context.attributes;
                      String? imgUrl = attrs['src'];
                      if (imgUrl != null) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Image.network(
                            imgUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                                    child: Icon(Icons.broken_image, size: 50)),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  TagExtension(
                    tagsToExtend: {"a"},
                    builder: (context) {
                      final attrs = context.attributes;
                      String? href = attrs['href'];
                      return GestureDetector(
                        onTap: () {
                          if (href != null) openUrl(href);
                        },
                        child: Text(
                          context.element?.text ?? "Ссылка",
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    ]);
  }
}
