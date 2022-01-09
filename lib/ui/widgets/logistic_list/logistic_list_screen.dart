import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lazy_post/domain/entity/point.dart';
import 'package:provider/src/provider.dart';

import 'logistic_list_model.dart';

class LogisticListScreen extends StatefulWidget {
  const LogisticListScreen({Key? key}) : super(key: key);

  @override
  _LogisticListScreenState createState() => _LogisticListScreenState();
}

class _LogisticListScreenState extends State<LogisticListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Компании'),
        ),
        body: const _LogisticListWidget());
  }
}

class _LogisticListWidget extends StatelessWidget {
  const _LogisticListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<LogisticListViewModel>();
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: model.logistics.length,
      itemExtent: 220,
      itemBuilder: (BuildContext context, int index) {
        return _LogisticListRowWidget(index: index);
      },
    );
  }
}

class _LogisticListRowWidget extends StatelessWidget {
  final int index;

  const _LogisticListRowWidget({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<LogisticListViewModel>();
    final logistic = model.logistics[index];
    final imgUrl = model.getImageUrl(logistic.logisticId);

    final fromPoints = createDropDownItems(model.logistics[index].from);
    final toPoints = createDropDownItems(model.logistics[index].to);
    // for select
    // DropListModel dropListModel = DropListModel(fromPoints);
    // OptionItem optionItemSelected = fromPoints[0];


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(children: [
              Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(image: AssetImage(imgUrl), width: 70),
                ),

                const SizedBox(width: 15),
                Expanded(

                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            logistic.nameRu,
                            style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${DateFormat('dd.MM.yyyy').format(logistic.deliveryDate)} (дата доставки)',
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),Text(
                            '${logistic.price.toString()} грн',
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]
                    ))]),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Text(logistic.from[0].city, textAlign: TextAlign.left, style: const TextStyle(fontSize: 15)),
                        Text(logistic.from[0].area, textAlign: TextAlign.left, style: const TextStyle(fontSize: 10)),
                        Text(logistic.from[0].pointNumber.toString(), textAlign: TextAlign.left, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(logistic.from[0].pointType?? '', textAlign: TextAlign.left, style: const TextStyle(fontSize: 10),),
                        Text('${logistic.from[0].dist.toStringAsFixed(2)} км', textAlign: TextAlign.left,),
                        Text('(${logistic.from.length} шт)', textAlign: TextAlign.left,style: const TextStyle(fontSize: 10)),
                      ],),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(logistic.to[0].city, textAlign: TextAlign.right,style: const TextStyle(fontSize: 15)),
                          Text(logistic.to[0].area, textAlign: TextAlign.right, style: const TextStyle(fontSize: 10)),
                          Text(logistic.to[0].pointNumber.toString(), textAlign: TextAlign.right, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(logistic.to[0].pointType?? '', textAlign: TextAlign.right, style: const TextStyle(fontSize: 10)),
                          Text('${logistic.to[0].dist.toStringAsFixed(2)} км', textAlign: TextAlign.right),
                          Text('(${logistic.to.length} шт)', textAlign: TextAlign.right, style: const TextStyle(fontSize: 10)),
                        ],),
                    )


                  ],
                )]),
                // Text(
                //   logistic.price.toString(),
                //   maxLines: 2,
                //   overflow: TextOverflow.ellipsis,
                // ),


          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model.onLogisticTap(context, index),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem> createDropDownItems(List<Point> list) {
    List<DropdownMenuItem> l = [];
    for (var i in list) {
      l.add(DropdownMenuItem<dynamic>(
          child: Text('${i.pointNumber} (${i.dist.toStringAsFixed(2)} км)',
            style: const TextStyle(fontSize: 10),
          ),
          value: i.pointNumber));
    }
    return l;
  }

}
