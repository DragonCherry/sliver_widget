# sliver_widget

Lightweight widget wrapper that show or hide child widget by position of FlexibleSpaceBar used in SliverAppBar.

## Getting Started

```dart
SliverAppBar(
  title: SliverWidget(
    child: Text('SliverAppBarSample'),
    isFadeByPositionRatio: false,
    visibility: SliverWidgetVisibility.visibleWhenCollapsed),
      flexibleSpace: FlexibleSpaceBar(
        title: SliverWidget(
          child: Text('SliverAppBarSample'),
          isFadeByPositionRatio: true,
          visibility: SliverWidgetVisibility.visibleWhenExpanded),
        background: Image.network(
          'https://www.gstatic.com/webp/gallery/1.jpg',
          fit: BoxFit.cover)),
          ...
```
You can check full example at https://github.com/DragonCherry/flutter_study.
Run app > widget > sliver_app_bar_sample