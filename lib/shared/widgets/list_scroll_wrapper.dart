import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListScrollWrapper extends StatefulWidget {
  const ListScrollWrapper({
    super.key,
    required this.isScrollMore,
    required this.onScrollCallback,
    required this.child,
  });

  final bool isScrollMore;
  final Future<void> Function() onScrollCallback;
  final Widget child;

  @override
  State<ListScrollWrapper> createState() => _ListScrollWrapperState();
}

class _ListScrollWrapperState extends State<ListScrollWrapper> {
  late ScrollController scrollController;

  bool preventCall = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(loadMore)
      ..dispose();
    super.dispose();
  }

  void loadMore() {
    final position = scrollController.position;
    final currPixel = position.pixels;
    final nextExtentTrigger = position.maxScrollExtent * 0.9;
    final isScrollDown =
        position.userScrollDirection == ScrollDirection.reverse;

    if (currPixel > nextExtentTrigger && isScrollDown && widget.isScrollMore) {
      // wait till previous one done
      if (!preventCall) {
        preventCall = true;
        widget.onScrollCallback().then((_) => preventCall = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: widget.child,
    );
  }
}
