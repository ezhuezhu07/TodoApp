import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/providers/size_providers.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';

class CardWidget extends StatelessWidget {
  List<Color> colorData = [
    blueShadeLight,
    cherrylight,
    greenlight,
    orangelight,
    pinklight,
    brownlight,
  ];

  List<Color> fontColorData = [blueShade, cherry, green, orange, pink, brown];

  // final Colors.white = Colors.white;

  @override
  Widget build(BuildContext context) {
    final todoDashboardProvider =
        Provider.of<TodoDashboardProvider>(context, listen: false);
    return Consumer<SizeProvider>(builder: (context, sizeProvider, _) {
      return Padding(
        padding: EdgeInsets.only(top: sizeProvider.screenHeight * 0.03),
        child: GridView.builder(
          itemCount: colorData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: (sizeProvider.todoStatCardHeight * 0.3),
            // childAspectRatio: 1 / 1,
          ),
          itemBuilder: (context, index) {
            return SizedBox(
                height: sizeProvider.screenHeight * (1 / 5),
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () async {
                        // print(
                        //     'Before Card title : ${todoDashboardProvider.selectedCard} $index');

                        todoDashboardProvider.setSelecedCard(
                            todoDashboardProvider.todoTypes[index]);
                      },
                      child: Consumer<TodoDashboardProvider>(
                          builder: (context, myProvider, child) {
                        return Card(
                          color: myProvider.selectedCard ==
                                  myProvider.todoTypes[index]
                              ? colorData[index]
                              : darkmgray,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  (sizeProvider.todoStatCardHeight * 0.025))),
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GridTile(
                                header: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    myProvider.todoTypes[index],
                                    style: TextStyle(
                                      color: fontColorData[index],
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '${myProvider.todoCountList[myProvider.todoTypes[index]]}',
                                    style: TextStyle(
                                        color: fontColorData[index],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // child: Container(width: 0),
                              )),
                        );
                      })
                      // Consumer<TodoDashboardProvider>(
                      //   builder: (_, myProvider, __) {
                      //     print('Only card is build');
                      //     return ;
                      //   },
                      // ))
                      ,
                    )));
          },
        ),
      );
    });
  }
}
