import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/projects.dart';
import '../theme/app_theme.dart';
import '../widgets/particle_background.dart';
import '../widgets/project_card.dart';
import '../widgets/project_modal.dart';
import '../widgets/typewriter_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String _activeFilter = 'All';
  bool _toastVisible = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();

  final List<String> _filters = ['All', 'Flutter', 'IoT', 'UI/UX', 'Web App'];
  final List<String> _skills = [
    'Flutter', 'Dart', 'IoT', 'Figma', 'Firebase',
    'REST APIs', 'UI/UX', 'State Management', 'Web Dev',
  ];

  List<ProjectModel> get _filteredProjects => _activeFilter == 'All'
      ? projects
      : projects.where((p) => p.category == _activeFilter).toList();

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: 'shikhar11x@gmail.com'));
    setState(() => _toastVisible = true);
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) setState(() => _toastVisible = false);
  }

  void _showProject(ProjectModel project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      builder: (_) => ProjectModal(project: project),
    );
  }

  void _scrollToProjects() {
    final ctx = _projectsKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          ParticleBackground(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 32 : 16,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildNav(),
                      const SizedBox(height: 24),
                      _buildHero(isWide),
                      const SizedBox(height: 20),
                      _buildSkillsBar(),
                      const SizedBox(height: 24),
                      SizedBox(key: _projectsKey, height: 0),
                      _buildSectionLabel('Selected Projects'),
                      const SizedBox(height: 12),
                      _buildFilterBar(),
                      const SizedBox(height: 16),
                      _buildProjectsGrid(isWide),
                      const SizedBox(height: 24),
                      _buildBottomCards(isWide),
                      const SizedBox(height: 16),
                      _buildFooter(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Toast
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _toastVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: AnimatedSlide(
                offset: _toastVisible ? Offset.zero : const Offset(0, 0.3),
                duration: const Duration(milliseconds: 250),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      border: Border.all(color: const Color(0x26FFFFFF)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Email copied to clipboard!',
                          style: TextStyle(
                              fontSize: 13, color: AppTheme.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── NAV ──
  Widget _buildNav() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0x0AFFFFFF),
        border: Border.all(color: const Color(0x14FFFFFF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('SB',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: AppTheme.textPrimary)),
          Row(
            children: ['Home', 'Projects', 'Contact', 'Resume']
                .map((item) => Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(item,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Color(0x80FFFFFF),
                              letterSpacing: 0.5)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  // ── HERO ──
  Widget _buildHero(bool isWide) {
    return Container(
      padding: EdgeInsets.all(isWide ? 52 : 28),
      decoration: BoxDecoration(
        color: const Color(0x0AFFFFFF),
        border: Border.all(color: const Color(0x1AFFFFFF)),
        borderRadius: BorderRadius.circular(24),
      ),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildHeroContent()),
                const SizedBox(width: 40),
                _buildAvatar(),
              ],
            )
          : _buildHeroContent(),
    );
  }

  Widget _buildHeroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x1AFFFFFF)),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(seconds: 1),
                builder: (_, v, child) => Transform.scale(
                    scale: v, child: child),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.green,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text('AVAILABLE FOR WORK',
                  style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 3,
                      color: Color(0x66FFFFFF))),
            ],
          ),
        ),
        const SizedBox(height: 20),
        RichText(
          text: const TextSpan(
            style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w700,
                letterSpacing: -2,
                height: 1.05,
                color: AppTheme.textPrimary),
            children: [
              TextSpan(text: 'Shikhar\n'),
              TextSpan(
                  text: '// ',
                  style: TextStyle(color: Color(0x33FFFFFF))),
              TextSpan(text: 'Bajpai'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Text('B.Tech 2027 · KR Mangalam University',
            style: TextStyle(
                fontSize: 13, color: Color(0x66FFFFFF), letterSpacing: 0.5)),
        const SizedBox(height: 10),
        const SizedBox(height: 54, child: TypewriterText()),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _buildBtn('View Projects ↓', primary: true, onTap: _scrollToProjects),
            _buildBtn('Contact Me →', onTap: _copyEmail),
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 200,
      height: 236,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -8, top: -8, right: -8, bottom: -8,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x0FFFFFFF)),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/pfp.jpeg',
              width: 200,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 200,
                height: 220,
                decoration: BoxDecoration(
                  color: const Color(0x1AFFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.person,
                    size: 64, color: Color(0x33FFFFFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── SKILLS BAR ──
  Widget _buildSkillsBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0x08FFFFFF),
        border: Border.all(color: const Color(0x12FFFFFF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: _skills
            .map((s) => Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0x1AFFFFFF)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(s,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0x80FFFFFF))),
                ))
            .toList(),
      ),
    );
  }

  // ── SECTION LABEL ──
  Widget _buildSectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
          fontSize: 10,
          letterSpacing: 4,
          color: Color(0x4DFFFFFF)),
    );
  }

  // ── FILTER BAR ──
  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters
            .map((f) => GestureDetector(
                  onTap: () => setState(() => _activeFilter = f),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 7),
                    decoration: BoxDecoration(
                      color: _activeFilter == f
                          ? Colors.white
                          : Colors.transparent,
                      border: Border.all(
                        color: _activeFilter == f
                            ? Colors.white
                            : const Color(0x1FFFFFFF),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      f,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: _activeFilter == f
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: _activeFilter == f
                            ? Colors.black
                            : const Color(0x73FFFFFF),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ── PROJECTS GRID ──
  Widget _buildProjectsGrid(bool isWide) {
    final filtered = _filteredProjects;
    final cols = isWide ? 3 : 2;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: 220,
      ),
      itemCount: filtered.length,
      itemBuilder: (_, i) => ProjectCard(
        project: filtered[i],
        animDelay: 300 + i * 100,
        onTap: () => _showProject(filtered[i]),
      ),
    );
  }

  // ── BOTTOM CARDS ──
  Widget _buildBottomCards(bool isWide) {
    final contactCard = _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Let's Connect",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 10),
          const Text(
              'Open to Flutter internships, freelance projects, and exciting collabs.',
              style: TextStyle(
                  fontSize: 13, color: Color(0x73FFFFFF), height: 1.7)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildLnk('GitHub ↗',
                  onTap: () => _openUrl('https://github.com/shikhar11x')),
              _buildLnk('LinkedIn ↗',
                  onTap: () => _openUrl(
                      'https://www.linkedin.com/in/shikharbajpai1/')),
              _buildLnk('Email Me',
                  onTap: () => _openUrl('mailto:shikhar11x@gmail.com')),
              _buildLnk('Copy Email', onTap: _copyEmail),
            ],
          ),
        ],
      ),
    );

    final resumeCard = _buildGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Resume',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                  color: AppTheme.textPrimary)),
          const SizedBox(height: 10),
          const Text(
              'My latest resume — skills, projects, internships and achievements all in one place.',
              style: TextStyle(
                  fontSize: 13, color: Color(0x73FFFFFF), height: 1.7)),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildLnk('View PDF ↗',
                  onTap: () => _openUrl(
                      'https://github.com/shikhar11x')), // replace with actual PDF link
              _buildLnk('Download ↓',
                  onTap: () => _openUrl(
                      'https://github.com/shikhar11x')), // replace with actual PDF link
            ],
          ),
        ],
      ),
    );

    if (isWide) {
      return Row(
        children: [
          Expanded(child: contactCard),
          const SizedBox(width: 16),
          Expanded(child: resumeCard),
        ],
      );
    } else {
      return Column(
        children: [contactCard, const SizedBox(height: 16), resumeCard],
      );
    }
  }

  Widget _buildGlassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0x0AFFFFFF),
        border: Border.all(color: const Color(0x17FFFFFF)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildLnk(String label, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x1FFFFFFF)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xB3FFFFFF),
                fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildBtn(String label,
      {bool primary = false, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
        decoration: BoxDecoration(
          color: primary ? Colors.white : Colors.transparent,
          border: Border.all(
              color: primary ? Colors.white : const Color(0x29FFFFFF)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primary ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  // ── FOOTER ──
  Widget _buildFooter() {
    return Center(
      child: Text(
        '© 2026 Shikhar Bajpai · Built with Flutter love & dark energy',
        style: const TextStyle(
            fontSize: 11, color: Color(0x33FFFFFF), letterSpacing: 1),
        textAlign: TextAlign.center,
      ),
    );
  }
}


