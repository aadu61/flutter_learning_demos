import 'dart:math';

import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString noOfPlayers = RxString("");
  RxString noOfCoins = RxString("");
  Rxn<CoinGame>? coinGame = Rxn<CoinGame>();
  Rxn<Map<int, List<int>>>? coineDistrubutions = Rxn<Map<int, List<int>>>();

  void playGame() {
    try {
      int numPlayers = int.parse(noOfPlayers.value.toString());
      int numCoins = int.parse(noOfCoins.value.toString());

      List<int> players = List.generate(numPlayers, (index) => index + 1);
      List<int> coins = List.generate(numCoins, (_) => (Random().nextInt(100) + 1));

      Map<int, List<int>> playerCoins = {};

      for (int i = 0; i < numPlayers; i++) {
        playerCoins[i + 1] = [];
      }

      for (int i = 0; i < numCoins; i++) {
        var indexOfCoins = i % numPlayers + 1;
        playerCoins[indexOfCoins]?.add(coins[i]);
      }

      /// region old method
/*      if (players.length > coins.length) {
        for (int i = 0; i < players.length; i++) {
          for (int j = 0; j < coins.length; j++) {
            playerCoins.addIf(i == j, players[i], coins[j].toString());
          }
        }
      } else if (coins.length > players.length) {
        for (int i = 0; i < coins.length; i++) {
          var oldI = 0;
          if (i >= players.length) {
            for (int j = 0; j < players.length; j++) {
              if (i != oldI) {
                playerCoins.update(players[j], (value) => "$value,${coins[i]}");
                oldI = i;
                break;
              }

              // playerCoins.addEntries({players[j]:coins[i].toString()}.entries);
            }
          } else {
            for (int j = 0; j < players.length; j++) {
              playerCoins.addIf(j == i, players[j], coins[i]);

              // playerCoins.addEntries({players[j]:coins[i].toString()}.entries);
            }
          }
        }

        // var seprationValue =  ((coins.length/players.length)%2); //even
      } else {
        playerCoins = Map.fromIterables(players, coins);
      }*/

      ///endregion

      coineDistrubutions?.value = playerCoins;
      print("Invalid coins: ${coins.toString()}");
      print("Invalid players: ${players.toString()}");
      print("Invalid playerCoins: $playerCoins");
      print("Invalid playerCoins: $coineDistrubutions");

      Map<int, String> localPlayerCoins = {};
      Map<int, int> distrubitudeCoinWithValue = {};
      Map<int, int> coinsWithLength = {};
      for (int key in playerCoins.keys) {
        localPlayerCoins[key] = playerCoins[key]!.join(', ');
        distrubitudeCoinWithValue[key] = playerCoins[key]!.fold(0, (p, c) => p + c);
        coinsWithLength[key] = playerCoins[key]!.length;
      }
      coinGame?.value = CoinGame(numPlayers, numCoins, localPlayerCoins, distrubitudeCoinWithValue,coinsWithLength);

      print("Invalid coinGame: ${coinGame?.value.toString()}");
    } catch (e) {
      // Handle invalid input
      print("Invalid input: $e");
    }
  }

  getMaximNuberOfCoinValuePlayer(){
    var thevalue = 0;
    var thekey;
    coinGame?.value?.coinsWithLength.forEach((key, value) {
      if(value>thevalue) {
        thevalue = value;
        thekey = key;
      }
    });

    return thekey;

  }
}

class CoinGame {
  final int numPlayers;
  final int numCoins;
  // final Map<int,Map<int,int>> listOfCollections;
  final Map<int, String> playerCoins;
  final Map<int, int> distrubitudeCoinWithValue;
  Map<int, int> coinsWithLength = {};

  CoinGame(this.numPlayers, this.numCoins, this.playerCoins, this.distrubitudeCoinWithValue,this.coinsWithLength);

  @override
  String toString() {
    return 'CoinGame{numPlayers: $numPlayers, numCoins: $numCoins, playerCoins: $playerCoins, distrubitudeCoinWithValue: $distrubitudeCoinWithValue, coinsWithLength: $coinsWithLength}';
  }
}
