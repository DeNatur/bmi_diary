import 'dart:developer';

import 'package:flutter/widgets.dart';

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  final bool fade;
  ExpandedSection({this.expand = false, this.child, this.fade = true});

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with TickerProviderStateMixin {
  AnimationController expandController;
  AnimationController opacityController;
  Animation<double> animation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    opacityController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: expandController, curve: Curves.fastOutSlowIn));
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
      if (widget.fade) opacityController.forward();
    } else {
      expandController.reverse();
      if (widget.fade) opacityController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.fade
        ? FadeTransition(
            opacity: opacityAnimation,
            child: SizeTransition(
                axisAlignment: 1.0, sizeFactor: animation, child: widget.child),
          )
        : SizeTransition(
            axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
