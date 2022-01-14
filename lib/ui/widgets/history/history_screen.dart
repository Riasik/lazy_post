import 'package:flutter/material.dart';
import 'package:lazy_post/ui/widgets/history/history_model.dart';
import 'package:provider/src/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HistoryViewModel>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('История'),
        ),
        body:  ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: model.parcels.length,
          itemExtent: 120,
          itemBuilder: (BuildContext context, int index) {
            return _PointHistoryRow(index: index);
          },
        ));
  }
}

 class _PointHistoryRow extends StatelessWidget {
  final int index;
  const _PointHistoryRow({Key? key, required this.index}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     final model = context.read<HistoryViewModel>();
     final parcel = model.parcels[index];
     return Text('id');
   }
 }
 

