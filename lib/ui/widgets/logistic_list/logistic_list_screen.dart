import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';
import 'package:provider/src/provider.dart';

import 'logistic_list_model.dart';

class LogisticListScreen extends StatelessWidget {
  const LogisticListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Компании'),
        ),
        body: getBody(context));
  }

  Widget getBody(BuildContext context) {
    final model = context.watch<LogisticListViewModel>();
    if (model.loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      if (model.logistics.length == 0) {
        _showToast('${model.errMessage}');
      }
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
  void _showToast(String err) => Fluttertoast.showToast(
      msg: err,
      textColor: Colors.white,
      backgroundColor: AppColors.btnColorGrey,
      fontSize: 18);
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
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(image: AssetImage(imgUrl), width: 50),
                ),
                const SizedBox(width: 15),
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            logistic.nameRu,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${DateFormat('dd.MM.yyyy').format(
                                logistic.deliveryDate)} (дата доставки)',
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${logistic.price.toString()} грн',
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]))
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(logistic.from[0].city,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 15)),
                          Text(logistic.from[0].area,
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10)),
                          Text('№ ${logistic.from[0].pointNumber}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            logistic.from[0].pointType ?? '',
                            textAlign: TextAlign.left,
                            style: const TextStyle(fontSize: 10),
                          ),
                          Text(
                            '${logistic.from[0].dist.toStringAsFixed(2)} км',
                            textAlign: TextAlign.left,
                          ),
                          Text('(${logistic.from.length} шт)',
                              textAlign: TextAlign.left,
                              style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.black,
                        height: 100,
                        thickness: 2,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(logistic.to[0].city,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 15)),
                          Text(logistic.to[0].area,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 10)),
                          Text('№ ${logistic.to[0].pointNumber}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(logistic.to[0].pointType ?? '',
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 10)),
                          Text('${logistic.to[0].dist.toStringAsFixed(2)} км',
                              textAlign: TextAlign.right),
                          Text('(${logistic.to.length} шт)',
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 10)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
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
}
