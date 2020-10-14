library sliver_widget;

//import 'dart:developer';

import 'package:flutter/material.dart';

enum SliverWidgetVisibility {
  visibleWhenCollapsed,
  invisibleWhenCollapsed,
  visibleWhenExpanded,
  invisibleWhenExpanded
}

class SliverWidget extends StatefulWidget {
  final Widget child;
  final bool isFadeByPositionRatio;
  final SliverWidgetVisibility visibility;
  final bool isAnimated;
  final Duration animationDuration;

  const SliverWidget(
      {Key key,
      @required this.child,
      this.isFadeByPositionRatio = true,
      this.visibility = SliverWidgetVisibility.visibleWhenCollapsed,
      this.isAnimated = true,
      this.animationDuration = const Duration(milliseconds: 250)})
      : super(key: key);
  @override
  _SliverWidgetState createState() {
    return _SliverWidgetState();
  }
}

class _SliverWidgetState extends State<SliverWidget> {
  ScrollPosition _position;
  double _ratio = 1;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType();

    if (settings != null && settings.maxExtent > settings.minExtent) {
      _ratio = (settings.currentExtent - settings.minExtent) /
          (settings.maxExtent - settings.minExtent);
    }
    //log('max: ${settings.maxExtent}, min: ${settings.minExtent}, cur: ${settings.currentExtent}, ratio: $_ratio');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFadeByPositionRatio) {
      switch (widget.visibility) {
        case SliverWidgetVisibility.invisibleWhenCollapsed:
        case SliverWidgetVisibility.visibleWhenExpanded:
          return Opacity(opacity: _ratio, child: widget.child);
        default:
          return Opacity(opacity: 1 - _ratio, child: widget.child);
      }
    } else {
      double opacity = 0;
      final isCollapsed = _ratio == 0;
      final isExpanded = _ratio == 1;
      switch (widget.visibility) {
        case SliverWidgetVisibility.visibleWhenCollapsed:
          opacity = isCollapsed ? 1 : 0;
          break;
        case SliverWidgetVisibility.invisibleWhenCollapsed:
          opacity = isCollapsed ? 0 : 1;
          break;
        case SliverWidgetVisibility.visibleWhenExpanded:
          opacity = isExpanded ? 1 : 0;
          break;
        case SliverWidgetVisibility.invisibleWhenExpanded:
          opacity = isExpanded ? 0 : 1;
          break;
      }
      if (widget.isAnimated) {
        return AnimatedOpacity(
            opacity: opacity,
            child: widget.child,
            duration: widget.animationDuration);
      } else {
        return Opacity(opacity: opacity, child: widget.child);
      }
    }
  }
}
