import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/projects.dart';
import '../theme/app_theme.dart';

class ProjectModal extends StatefulWidget {
  final ProjectModel project;

  const ProjectModal({super.key, required this.project});

  @override
  State<ProjectModal> createState() => _ProjectModalState();
}

class _ProjectModalState extends State<ProjectModal> {
  int _imgIndex = 0;

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: Color(0x1FFFFFFF)),
          left: BorderSide(color: Color(0x1FFFFFFF)),
          right: BorderSide(color: Color(0x1FFFFFFF)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.num,
                        style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: 3,
                          color: Color(0x40FFFFFF),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0x26FFFFFF)),
                      color: const Color(0x0DFFFFFF),
                    ),
                    child: const Icon(Icons.close,
                        size: 16, color: Color(0x99FFFFFF)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0x12FFFFFF), height: 1),
          // scrollable body
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image slider
                  if (project.previews.isNotEmpty) ...[
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0x14FFFFFF)),
                        color: const Color(0x0AFFFFFF),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              project.previews[_imgIndex],
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Center(
                                child: Icon(Icons.image_not_supported,
                                    color: Color(0x33FFFFFF), size: 40),
                              ),
                            ),
                          ),
                          if (project.previews.length > 1) ...[
                            Positioned(
                              left: 8,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    _imgIndex = (_imgIndex - 1 + project.previews.length) %
                                        project.previews.length;
                                  }),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0x1AFFFFFF),
                                    ),
                                    child: const Icon(Icons.chevron_left,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () => setState(() {
                                    _imgIndex =
                                        (_imgIndex + 1) % project.previews.length;
                                  }),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0x1AFFFFFF),
                                    ),
                                    child: const Icon(Icons.chevron_right,
                                        color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  project.previews.length,
                                  (i) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    width: i == _imgIndex ? 16 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: i == _imgIndex
                                          ? Colors.white
                                          : const Color(0x40FFFFFF),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  // description
                  Text(
                    project.fullDesc,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                      color: Color(0x8CFFFFFF),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // tags
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: project.tags
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0x1AFFFFFF)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                t,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0x80FFFFFF),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Color(0x12FFFFFF)),
                  const SizedBox(height: 16),
                  // links
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: project.links
                        .map((l) => GestureDetector(
                              onTap: () => _openUrl(l.url),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 11),
                                decoration: BoxDecoration(
                                  color: l.primary
                                      ? Colors.white
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: l.primary
                                        ? Colors.white
                                        : const Color(0x26FFFFFF),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  l.label,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: l.primary
                                        ? Colors.black
                                        : const Color(0xCCFFFFFF),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
