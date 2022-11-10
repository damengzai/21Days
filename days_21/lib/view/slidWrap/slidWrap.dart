import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SlidWrap extends StatefulWidget {
  final GlobalKey? moveKey;
  final Widget child;
  final Widget slidWidget;
  final double sideWidth;

  SlidWrap({this.moveKey, required this.child, required this.slidWidget, required this.sideWidth}):super(key: moveKey);

  @override
  State<StatefulWidget> createState() => _SlidWrapState();
}

class _SlidWrapState extends State<SlidWrap>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  double moveMaxLength = 0;
  double start = 0;
  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    moveMaxLength = widget.sideWidth;
    controller = AnimationController(
      lowerBound: 0,
      upperBound: moveMaxLength,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
        start = controller?.value ?? 0;
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: Stack(
          children: [
              Positioned(
                right: 0,
                child: widget.slidWidget,
              ),
            Positioned(
              // width: MediaQuery.of(context).size.width,
              child: widget.child,
              left: -start,
              right: start,
            ),
          ],
        ),
        onHorizontalDragDown: (DragDownDetails details) {
          //开始
          print('object-----onHorizontalDragDown');
        },
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          //滑动中
          setState(() {
            start -= details.delta.dx;
            if (start <= 0) {
              start = 0;
            }
            if (start >= moveMaxLength) {
              start = moveMaxLength;
            }
          });
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          controller?.value = start;
          if (start == moveMaxLength)
            isOpen = true;
          else if (start > moveMaxLength / 2) {
            controller?.animateTo(moveMaxLength);
            isOpen = true;
          } else if (start <= moveMaxLength / 2) {
            controller?.animateTo(0);
            isOpen = false;
          }
        },
      ),
    );
  }
}
