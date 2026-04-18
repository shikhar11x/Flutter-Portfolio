import 'dart:math';
import 'package:flutter/material.dart';

class Particle {
  double x, y, vx, vy, radius, alpha;

  Particle(double w, double h, Random rng)
      : x = rng.nextDouble() * w,
        y = rng.nextDouble() * h,
        vx = (rng.nextDouble() - 0.5) * 0.4,
        vy = (rng.nextDouble() - 0.5) * 0.4,
        radius = rng.nextDouble() * 1.2 + 0.3,
        alpha = rng.nextDouble() * 0.35 + 0.05;

  void update(double w, double h, Random rng) {
    x += vx;
    y += vy;
    if (x < 0 || x > w || y < 0 || y > h) {
      x = rng.nextDouble() * w;
      y = rng.nextDouble() * h;
    }
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint();
    final linePaint = Paint()..strokeWidth = 0.4;

    for (final p in particles) {
      dotPaint.color = Color.fromRGBO(255, 255, 255, p.alpha);
      canvas.drawCircle(Offset(p.x, p.y), p.radius, dotPaint);
    }

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = particles[i].x - particles[j].x;
        final dy = particles[i].y - particles[j].y;
        final dist = sqrt(dx * dx + dy * dy);
        if (dist < 100) {
          final opacity = 0.07 * (1 - dist / 100);
          linePaint.color = Color.fromRGBO(255, 255, 255, opacity);
          canvas.drawLine(
            Offset(particles[i].x, particles[i].y),
            Offset(particles[j].x, particles[j].y),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlePainter old) => true;
}

class ParticleBackground extends StatefulWidget {
  final Widget child;
  const ParticleBackground({super.key, required this.child});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _rng = Random();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _initParticles(Size size) {
    if (_initialized) return;
    _initialized = true;
    for (int i = 0; i < 70; i++) {
      _particles.add(Particle(size.width, size.height, _rng));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);
      _initParticles(size);
      return AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          for (final p in _particles) {
            p.update(size.width, size.height, _rng);
          }
          return CustomPaint(
            painter: ParticlePainter(List.of(_particles)),
            child: widget.child,
          );
        },
      );
    });
  }
}
