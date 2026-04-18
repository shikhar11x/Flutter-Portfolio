class ProjectModel {
  final String num;
  final String title;
  final String shortDesc;
  final String fullDesc;
  final List<String> tags;
  final String category;
  final List<String> previews;
  final List<ProjectLink> links;

  const ProjectModel({
    required this.num,
    required this.title,
    required this.shortDesc,
    required this.fullDesc,
    required this.tags,
    required this.category,
    required this.previews,
    required this.links,
  });
}

class ProjectLink {
  final String label;
  final String url;
  final bool primary;

  const ProjectLink({
    required this.label,
    required this.url,
    this.primary = false,
  });
}

final List<ProjectModel> projects = [
  ProjectModel(
    num: '01',
    title: 'Flutter Todo App',
    shortDesc: 'Clean minimal Todo app with dark glass UI, task management and local storage using Hive.',
    fullDesc:
        'A clean and minimal Todo app built with Flutter featuring a dark glass UI, task management with priority levels, and persistent local storage using Hive. Supports adding, editing, deleting tasks with smooth animations throughout.',
    tags: ['Flutter', 'Dart', 'Hive', 'Local Storage', 'Animation'],
    category: 'Flutter',
    previews: ['assets/todo1.jpeg', 'assets/todo2.jpeg', 'assets/todo3.jpeg'],
    links: [
      ProjectLink(label: 'GitHub ↗', url: 'https://github.com/shikhar11x/Flutter-TodoApp', primary: true),
      ProjectLink(label: 'Download APK', url: 'https://github.com/shikhar11x/Flutter-TodoApp/releases'),
    ],
  ),
  ProjectModel(
    num: '02',
    title: 'Flutter Dice App',
    shortDesc: 'Animations, state management and responsive UI design in a clean Flutter project.',
    fullDesc:
        'A fun Flutter project showcasing smooth dice roll animations, state management with Provider, and a fully responsive UI. Built to explore Flutter\'s animation system and widget lifecycle in depth.',
    tags: ['Flutter', 'Dart', 'Animation', 'State Management', 'Provider'],
    category: 'Flutter',
    previews: ['assets/dice.png'],
    links: [
      ProjectLink(label: 'GitHub ↗', url: 'https://github.com/shikhar11x/Flutter-Dice', primary: true),
      ProjectLink(label: 'Live Demo', url: 'https://flutter-dice-blazestack.vercel.app/'),
    ],
  ),
  ProjectModel(
    num: '03',
    title: 'Smart Classroom IoT',
    shortDesc: 'Real-time classroom monitoring system with live dashboard and environmental analytics.',
    fullDesc:
        'An IoT-based classroom environment monitoring system that tracks temperature, humidity, CO2 levels, and occupancy in real time. Features a live web dashboard with historical charts and alert thresholds for unhealthy conditions.',
    tags: ['IoT', 'Arduino', 'Dashboard', 'Real-time', 'Charts', 'Firebase'],
    category: 'IoT',
    previews: ['assets/iot1.png', 'assets/iot2.png'],
    links: [
      ProjectLink(
          label: 'GitHub ↗',
          url: 'https://github.com/shikhar11x/IoT-Based-Smart-Classroom-Environment-Monitoring-System-6th-SEM',
          primary: true),
      ProjectLink(label: 'Live Demo', url: 'https://smartclassroomk.vercel.app/'),
    ],
  ),
  ProjectModel(
    num: '04',
    title: 'Coding Interview Platform',
    shortDesc: 'Industry-ready platform with timed questions, DSA problems and performance tracking.',
    fullDesc:
        'A full web-based coding interview simulator with a DSA question bank, per-question timers, and a performance tracking dashboard. Helps students practice under real interview pressure with instant feedback.',
    tags: ['Web App', 'JavaScript', 'DSA', 'Timer', 'Performance Tracking'],
    category: 'Web App',
    previews: [
      'assets/codein1.png',
      'assets/codein2.png',
      'assets/codein3.png',
      'assets/codein4.png',
      'assets/codein5.png',
      'assets/codein6.png',
      'assets/codein7.png',
      'assets/codein8.png',
    ],
    links: [
      ProjectLink(label: 'GitHub ↗', url: 'https://github.com/shikhar11x/VirtualCodingInterviewPlatform', primary: true),
      ProjectLink(label: 'Live Demo', url: 'https://codein-blazestack.vercel.app/'),
    ],
  ),
  ProjectModel(
    num: '05',
    title: 'Delhi Metro Redesign',
    shortDesc: 'Modern UI/UX concept in Figma — cleaner navigation and premium commuter experience.',
    fullDesc:
        'A complete UI/UX redesign concept for the Delhi Metro app made in Figma. Focused on cleaner navigation flows, a modern visual language, improved accessibility, and a premium commuter experience for daily users.',
    tags: ['Figma', 'UI/UX', 'Prototyping', 'Design System', 'Mobile'],
    category: 'UI/UX',
    previews: [
      'assets/metro1.jpg',
      'assets/metro2.jpg',
      'assets/metro3.jpg',
      'assets/metro4.jpg',
      'assets/metro5.jpg',
      'assets/metro6.jpg',
      'assets/metro7.jpg',
      'assets/metro8.jpg',
      'assets/metro9.jpg',
      'assets/metro10.jpg',
    ],
    links: [
      ProjectLink(
          label: 'Open in Figma ↗',
          url: 'https://www.figma.com/design/RhKKiHmRMf2muWZUPr02Qm/TEAM-BlaZeSTACK?t=RP1i8ui770MlzzaW-1',
          primary: true),
    ],
  ),
];
