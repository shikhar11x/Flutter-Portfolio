import 'package:flutter/material.dart';
import '../data/projects.dart';
import '../theme/app_theme.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback onTap;
  final int animDelay;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.animDelay = 0,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _opacity = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.animDelay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: _hovered
                    ? const Color(0x0FFFFFFF)
                    : const Color(0x0AFFFFFF),
                border: Border.all(
                  color: _hovered
                      ? const Color(0x33FFFFFF)
                      : const Color(0x17FFFFFF),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.project.num,
                        style: const TextStyle(
                          fontSize: 10,
                          letterSpacing: 3,
                          color: Color(0x33FFFFFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'tap to expand',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1,
                          color: Color(0x2EFFFFFF),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFFFFF),
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      widget.project.shortDesc,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.6,
                        color: Color(0x73FFFFFF),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: widget.project.tags
                        .take(3)
                        .map((t) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0x1AFFFFFF)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                t,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Color(0x73FFFFFF),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
