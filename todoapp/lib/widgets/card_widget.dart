import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/controllers/size_controller.dart';
import 'package:todoapp/controllers/todo_dashboard_controller.dart';

class CardWidget extends StatelessWidget {
  List<String> cardTitle = [
    'Todos',
    'Completed',
    'Planning',
    'Development',
    'Testing',
    'Deployment'
  ];
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
    SizeController sizeController = Get.find<SizeController>();
    TodoDashboardController controller = Get.find<TodoDashboardController>();
    List<int> countList = [
      controller.todosCount,
      controller.completedTodosCount,
      controller.planningTodosCount,
      controller.developmentTodosCount,
      controller.testingTodosCount,
      controller.deploymentTodosCount
    ];
    return Padding(
      padding: EdgeInsets.only(top: sizeController.screenHeight * 0.03),
      child: GridView.builder(
        itemCount: colorData.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: (sizeController.todoStatCardHeight * 0.3),
          // childAspectRatio: 1 / 1,
        ),
        itemBuilder: (context, index) {
          return SizedBox(
            height: sizeController.screenHeight * (1 / 5),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  controller.selectedCard = cardTitle[index];
                  controller.update(
                      [controller.todoStatCard, controller.todoListView]);
                },
                child: Card(
                  color: controller.selectedCard == cardTitle[index]
                      ? colorData[index]
                      : darkmgray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          (sizeController.todoStatCardHeight * 0.025))),
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridTile(
                        header: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            cardTitle[index],
                            style: TextStyle(
                              color: fontColorData[index],
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          '${countList[index]}',
                          style: TextStyle(
                              color: fontColorData[index],
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        )),
                        // child: Container(width: 0),
                      )),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
