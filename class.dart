class BoardGame {
  final String theme; //, timeLength, publisher, designer, artist;
  int playerCount;
  final bool isAvailable;

  BoardGame({required this.theme, required this.playerCount, required this.isAvailable});

  BoardGame.available({required this.theme, required this.playerCount}) : isAvailable = true;


  @override
  String toString() {
    return "Theme: $theme \nPlayer Count: 2 - $playerCount \nAvaiblity: $isAvailable";
  }

}

void main() {
  var Ticket_to_ride = BoardGame.available(theme: "Trains", playerCount: 5);
  var splendor = BoardGame.available(theme: "Gems", playerCount: 4);
  var King_of_Tokyo = BoardGame(theme: "Monsters", playerCount: 6, isAvailable: false);

  splendor.playerCount = 8;
  print(splendor.toString());
}