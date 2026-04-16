import 'package:flutter/material.dart';

class ProjectModel {
  final String number;
  final String title;
  final String description;
  final List<String> tags;
  final bool hasGithub;
  final bool hasDemo;
  final bool hasFigma;

  const ProjectModel({
    required this.number,
    required this.title,
    required this.description,
    required this.tags,
    this.hasGithub = true,
    this.hasDemo = true,
    this.hasFigma = false,
  });
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const List<ProjectModel> projects = [
    ProjectModel(
      number: '01',
      title: 'Flutter Dice App',
      description:
          'Animations, state management and responsive UI design in a clean Flutter project.',
      tags: ['Flutter', 'Dart', 'Animation'],
    ),
    ProjectModel(
      number: '02',
      title: 'Smart Classroom IoT',
      description:
          'Real-time classroom monitoring system with live dashboard and environmental analytics.',
      tags: ['IoT', 'Dashboard', 'Real-time'],
    ),
    ProjectModel(
      number: '03',
      title: 'Coding Interview Platform',
      description:
          'Industry-ready platform with timed questions, DSA problems and performance tracking.',
      tags: ['Web App', 'DSA', 'Timer'],
    ),
    ProjectModel(
      number: '04',
      title: 'Delhi Metro Redesign',
      description:
          'Modern UI/UX concept in Figma — cleaner navigation and premium commuter experience.',
      tags: ['Figma', 'UI/UX', 'Design'],
      hasGithub: false,
      hasDemo: false,
      hasFigma: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            'SELECTED PROJECTS',
            style: TextStyle(
              color: Color(0xFF888888),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        // 2x2 grid
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ProjectCard(project: projects[0])),
            const SizedBox(width: 12),
            Expanded(child: _ProjectCard(project: projects[1])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _ProjectCard(project: projects[2])),
            const SizedBox(width: 12),
            Expanded(child: _ProjectCard(project: projects[3])),
          ],
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number
          Text(
            project.number,
            style: const TextStyle(
              color: Color(0xFF555555),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),

          // Title
          Text(
            project.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            project.description,
            style: const TextStyle(
              color: Color(0xFF888888),
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // Tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Color(0xFFAAAAAA),
                        fontSize: 10,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              if (project.hasGithub) ...[
                _ActionButton(label: 'GitHub ↗', onTap: () {}),
                const SizedBox(width: 8),
              ],
              if (project.hasDemo) _ActionButton(label: 'Live Demo', onTap: () {}),
              if (project.hasFigma) _ActionButton(label: 'Figma ↗', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}