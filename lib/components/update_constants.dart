//user board data
List<List<String>> userBoard = List.generate(10, (_) => List.filled(10, ""));

//generator board data
List<List<String>> generatorBoard =
    List.generate(10, (_) => List.filled(10, " "));
//list to display hints
final hintList = List<dynamic>.filled(0, [], growable: true);
int score = 0;
String timeFinal = "";
int hintsUsed = 0;
int wordhintused = 0;
int startandstop = 0;
