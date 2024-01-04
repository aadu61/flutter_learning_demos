import 'package:demo_pizza/controller/login_controller.dart';
import 'package:demo_pizza/utils/custom_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogicQuestion extends StatelessWidget {
  const LogicQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    var statusBar = MediaQuery.of(context).padding.top;
    return GetX<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: statusBar,
                ),
                CustomFunction.customEditText(
                    hintText: "Enter no of Players",
                    onChanged: (value) {
                      controller.noOfPlayers.value = value;
                    }),
                const SizedBox(
                  height: 30,
                ),
                CustomFunction.customEditText(
                    hintText: "Enter no of Coins",
                    onChanged: (value) {
                      controller.noOfCoins.value = value;
                    }),
                ElevatedButton(
                  onPressed: controller.playGame,
                  child: Text('Play'),
                ),
                if (controller.coinGame?.value != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Coins distribution: ${controller.coinGame?.value?.playerCoins}'),
                          Text('Player with maximum coins: Player ${controller.getMaximNuberOfCoinValuePlayer()}'),
                          Text(
                              'Player with maximum coin value: Player ${controller.coinGame?.value?.distrubitudeCoinWithValue.keys.reduce((a, b) => controller.coinGame!.value!.distrubitudeCoinWithValue[a]! > controller.coinGame!.value!.distrubitudeCoinWithValue[b]! ? a : b)}'),
                          const Text('All players with coins and total value:'),
                            for (var entry in controller.coinGame!.value!.coinsWithLength.entries)
                              Text('Player ${entry.key}: coins ${entry.value}  , total value ${controller.coinGame?.value?.distrubitudeCoinWithValue[entry.key]}')

                        ],
                      ),
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
        );
      },
    );
  }
}
