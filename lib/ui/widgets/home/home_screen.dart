import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lazy_post/ui/theme/app_colors.dart';
import 'package:provider/src/provider.dart';
import 'h_widgets/edit_location_widget.dart';
import 'h_widgets/inputs.dart';
import 'h_widgets/my_location_widget.dart';
import 'h_widgets/slider.dart';
import 'home_model.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: _getAppBar(context),
      body: const _Body(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.btnColorGrey,
        heroTag: "Удалить",
        child: const Icon(
          Icons.delete,
          size: 50,
        ),
        onPressed: () {
          model.setInit();
        },
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) {
    return AppBar(title: const Text('Hot Post'), actions: [
      // IconButton(
      //   icon: const Icon(Icons.history, color: Colors.white),
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(MainNavigationRouteNames.homeHistory);
      //   },
      // ),
    ]);
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeViewModel>();

    return ListView(children: [
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
                child: Stack(
                  children: [
                    Positioned(
                        right: 10,
                        top: 0,
                        height: 20,
                        child: IconButton(
                            onPressed: () {
                              model.viewEditWindow();
                            },
                            icon: Icon(Icons.edit,
                                color: model.viewEdits
                                    ? AppColors.btnColorBlue
                                    : AppColors.colorActive))),
                    Center(
                      child: Text(
                        'Информация о посылке:',
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: MediaQuery.of(context).size.width > 360
                                ? 18
                                : 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                  width: 500,
                  height: 270,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    //border: Border.all( color: Colors.black, width: 8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: model.viewEdits
                      ? Inputs(model: model)
                      : CarouselWithIndicatorDemo(
                          onChangedIcon: (int index) {
                            model.changeSizes(index);
                          },
                          current: model.parcelImgIndex)),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: Stack(children: [
                    Positioned(
                        right: 10,
                        top: 0,
                        height: 20,
                        child: IconButton(
                            onPressed: () {
                              model.viewEditLocationW();
                            },
                            color: model.viewEditLocation
                                ? AppColors.btnColorBlue
                                : AppColors.colorActive,
                            icon: Icon(Icons.edit))),
                    Center(
                        child: Text(
                      'Отправитель / Получатель:',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize:
                              MediaQuery.of(context).size.width > 360 ? 18 : 16,
                          fontWeight: FontWeight.normal),
                    )),
                  ])),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  //border: Border.all( color: Colors.black, width: 8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 179,
                      child: model.viewEditLocation
                          ? EditLocationWidget(
                              coordinates: Coordinates.sender,
                              title: 'Отправка с:',
                              model: model)
                          : MyLocationWidget(
                              model: model,
                              title: 'Укажите точку отправки',
                              coordinates: Coordinates.sender,
                              hasCoordinates:
                                  model.check(model.senderLocation)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 179,
                      child: model.viewEditLocation
                          ? EditLocationWidget(
                              coordinates: Coordinates.receiver,
                              title: 'Получить в:',
                              model: model)
                          : MyLocationWidget(
                              model: model,
                              title: 'Укажите точку получения',
                              coordinates: Coordinates.receiver,
                              hasCoordinates:
                                  model.check(model.receiverLocation)),
                    ),
                    // Text(
                    //   'Просмотрите ближайшие отделения',
                    //   style: TextStyle(
                    //       color: Colors.grey.shade700,
                    //       fontSize:
                    //       MediaQuery.of(context).size.width > 360 ? 18 : 16,
                    //       fontWeight: FontWeight.normal),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    ' Для поиска оптимально варианта доставки нажмите:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize:
                            MediaQuery.of(context).size.width > 360 ? 18 : 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              TextButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(200, 50)),
                      backgroundColor: MaterialStateProperty.all(
                        model.checkAllParams()
                            ? AppColors.btnColorBlue
                            : AppColors.btnColorGrey,
                      ),
                      shadowColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)))),
                  onPressed: () {
                    if (!model.checkAllParams()) {
                      _showToast(
                          'Заполните все поля!\nУкажите точку отправки и получения!');
                    } else {
                      model.checkLogisticResult(context);
                    }
                  },
                  child: Text('Поиск',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: Colors.white))),
            ],
          ),
        ),
      )
    ]);
  }

  void _showToast(String err) => Fluttertoast.showToast(
      msg: err,
      textColor: Colors.white,
      backgroundColor: AppColors.btnColorGrey,
      fontSize: 18);
}
