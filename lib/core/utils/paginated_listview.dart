import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginatedListView extends StatefulWidget {
  final int itemCount;
  final item;
  final isLoading;
  final bool hasReachedMax;
  final onLoadMore;

  const PaginatedListView(
      {Key key,
      this.itemCount,
      this.item,
      this.isLoading,
      this.hasReachedMax,
      this.onLoadMore})
      : super(key: key);

  @override
  _PaginatedListViewState createState() => _PaginatedListViewState();
}

class _PaginatedListViewState extends State<PaginatedListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.isLoading ? widget.itemCount + 1 : widget.itemCount,
        itemBuilder: (context, index) {
          return index >= widget.itemCount
              ? _buildBottomLoading()
              : widget.item(index);
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (!widget.isLoading &&
        maxScroll - currentScroll <= _scrollThreshold &&
        !widget.hasReachedMax) {
      widget.onLoadMore();
    }
  }

  _buildBottomLoading() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(child: CircularProgressIndicator()),
          height: 40,
          width: 30,
        ),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
