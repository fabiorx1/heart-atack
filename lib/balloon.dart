import 'package:invert_colors/invert_colors.dart';
import 'package:flutter/material.dart';

class Balloon extends StatefulWidget {
  final Color? color;
  final String? label;
  final bool canSplash;

  final AnimationController? positionController;

  const Balloon({
    Key? key,
    this.color,
    this.label,
    this.positionController,
    this.canSplash = true,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> with TickerProviderStateMixin {
  late final AnimationController _splashController;
  late final AnimationController _labelController;
  @override
  void dispose() {
    _splashController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _labelController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..addListener(
        () => setState(() {}),
      );
    _splashController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )
      ..addListener(
        () => setState(() {}),
      )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed &&
            _labelController.isDismissed) {
          _labelController.forward();
        }
      });

    if (widget.positionController != null) {
      widget.positionController!.addStatusListener((status) {
        if (status == AnimationStatus.completed &&
            _splashController.isDismissed) {
          _splashController.forward();
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 1 - _splashController.value,
          child: Material(
            color: widget.color ?? Colors.lightBlue,
            borderRadius: const BorderRadius.all(
              Radius.circular(72),
            ),
            child: InkWell(
              onTap: () {
                if (_splashController.isDismissed) {
                  _splashController.forward();
                }
              },
              child: const SizedBox(
                height: 66,
                width: 55,
                child: Center(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Visibility(
            visible: !_splashController.isDismissed,
            child: Opacity(
              opacity: _splashController.value,
              child: Image(
                image: const AssetImage('assets/splash.png'),
                width: 96,
                height: 96,
                color: widget.color,
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_labelController.isDismissed,
          child: Opacity(
            opacity: _labelController.value,
            child: Center(
              child: Text(
                widget.label ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
