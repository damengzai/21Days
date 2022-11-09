import 'dart:math';
// import 'package:days_21/view/flipCard/flipCardController.dart';
import 'package:flutter/material.dart';

enum FlipDirection {
  VERTICAL,
  HORIZONTAL,
}

enum CardSide {
  FRONT,
  BACK,
}

enum Fill {
  none,
  fillFront,
  fillBack,
}

class AnimationCard extends StatelessWidget {
  final Widget? child;
  final Animation<double>? animation;
  final FlipDirection? direction;

  AnimationCard({this.child, this.animation, this.direction});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation!,
      builder: (BuildContext context, Widget? child) {
        var transform = Matrix4.identity();
        transform.setEntry(3, 2, 0.001);
        if (direction == FlipDirection.VERTICAL) {
          transform.rotateX(animation!.value);
        } else {
          transform.rotateY(animation!.value);
        }
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: child,
    );
  }
}

typedef void BoolCallback(bool isFront);

///```dart
/// GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
///
/// @override
/// Widget build(BuildContext context) {
///   return FlipCard(
///     key: cardKey,
///     flipOnTouch: false,
///     front: Container(
///       child: RaisedButton(
///         onPressed: () => cardKey.currentState.toggleCard(),
///         child: Text('Toggle'),
///       ),
///     ),
///     back: Container(
///       child: Text('Back'),
///     ),
///   );
/// }
///```

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  final int speed;
  final FlipDirection direction;
  final VoidCallback? onFlip;
  final BoolCallback? onFlipDone;

  // final FlipCardController? controller;
  final Fill fill;
  final CardSide side;

  final bool flipOnTouch;
  final Alignment alignment;

  const FlipCard({
    Key? key,
    required this.front,
    required this.back,
    this.speed = 500,
    this.onFlip,
    this.onFlipDone,
    this.direction = FlipDirection.HORIZONTAL,
    // this.controller,
    this.flipOnTouch = true,
    this.alignment = Alignment.center,
    this.fill = Fill.none,
    this.side = CardSide.FRONT,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      FlipCardState(this.side == CardSide.FRONT);
}

class FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? _frontRotation;
  Animation<double>? _backRotation;

  bool isFront;

  FlipCardState(this.isFront);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      value: isFront ? 0.0 : 1.0,
      duration: Duration(
        milliseconds: widget.speed,
      ),
      vsync: this,
    );
    _frontRotation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(begin: 0.0, end: pi / 2)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
      TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2), weight: 50.0)
    ]).animate(controller!);

    _backRotation = TweenSequence([
      TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2), weight: 50.0),
      TweenSequenceItem<double>(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50)
    ]).animate(controller!);
    // widget.controller?.state = this;
  }

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    // widget.controller?.state ??= this;
  }

  Future<void> toggleCard() async {
    widget.onFlip?.call();
    final isFrontBefore = isFront;
    controller!.duration = Duration(milliseconds: widget.speed);
    final animation = isFront ? controller!.forward() : controller!.reverse();
    animation.whenComplete(() {
      if (widget.onFlipDone != null) widget.onFlipDone!(isFront);
      if (!mounted) return;
      setState(() {
        isFront = !isFrontBefore;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final frontPositioning = widget.fill == Fill.fillFront ? _fill : _noop;
    final backPositioning = widget.fill == Fill.fillBack ? _fill : _noop;
    final child = Stack(
      alignment: widget.alignment,
      fit: StackFit.passthrough,
      children: <Widget>[
        frontPositioning(_buildContent(front: true)),
        backPositioning(_buildContent(front: false))
      ],
    );

    if (widget.flipOnTouch) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: toggleCard,
        child: child,
      );
    }
    return child;
  }

  Widget _buildContent({required bool front}) {
    return IgnorePointer(
      ignoring: front ? !isFront : isFront,
      child: AnimationCard(
        animation: front ? _frontRotation : _backRotation,
        direction: widget.direction,
        child: front ? widget.front : widget.back,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}

Widget _fill(Widget child) => Positioned.fill(child: child);

Widget _noop(Widget child) => child;
