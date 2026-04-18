import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TypewriterText extends StatefulWidget {
  const TypewriterText({super.key});

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  final List<String> _phrases = [
    'Building modern Flutter apps with clean UI, smooth performance, and real-world solutions that actually matter.',
    'Turning ideas into polished mobile experiences — one widget at a time.',
    'Flutter · IoT · UI/UX · Always learning, always shipping.',
  ];

  int _phraseIdx = 0;
  int _charIdx = 0;
  bool _deleting = false;
  String _displayed = '';
  bool _showCursor = true;
  Timer? _typeTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 530), (_) {
      if (mounted) setState(() => _showCursor = !_showCursor);
    });
    Future.delayed(const Duration(milliseconds: 600), _tick);
  }

  void _tick() {
    if (!mounted) return;
    final current = _phrases[_phraseIdx];
    if (!_deleting) {
      _charIdx++;
      setState(() => _displayed = current.substring(0, _charIdx));
      if (_charIdx == current.length) {
        _deleting = true;
        _typeTimer = Timer(const Duration(milliseconds: 2800), _tick);
        return;
      }
      _typeTimer = Timer(const Duration(milliseconds: 38), _tick);
    } else {
      _charIdx--;
      setState(() => _displayed = current.substring(0, _charIdx));
      if (_charIdx == 0) {
        _deleting = false;
        _phraseIdx = (_phraseIdx + 1) % _phrases.length;
        _typeTimer = Timer(const Duration(milliseconds: 400), _tick);
        return;
      }
      _typeTimer = Timer(const Duration(milliseconds: 18), _tick);
    }
  }

  @override
  void dispose() {
    _typeTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          height: 1.8,
          color: AppTheme.textSecondary,
        ),
        children: [
          TextSpan(text: _displayed),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: AnimatedOpacity(
              opacity: _showCursor ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100),
              child: Container(
                width: 2,
                height: 14,
                margin: const EdgeInsets.only(left: 2),
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
