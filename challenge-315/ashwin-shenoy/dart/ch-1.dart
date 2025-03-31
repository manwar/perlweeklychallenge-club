/// Solution to task 1
///
/// Title: "Find Words"
///
/// You are given a list of words and a character.
/// Write a script to return the index of word in the list where you find the given character.
///
/// URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-315/
///
/// Algorithm details:
///
///    Time complexity:
///
///       - Best case scenario    : O(N²)
///       - Worst case scenario   : O(N²)
///       - Average case scenario : O(N²)
///
///    Space complexity:
///
///       - Best case scenario    : O(N)
///       - Worst case scenario   : O(N)
///       - Average case scenario : O(N)
///
/// This function takes a list of strings [words_list] and a string [character] and returns
/// a list of the indexes of the words that contains the given [character].
List<int> solution(List<String> words_list, String character) {
  List<int> words_index = [];

  for (String word in words_list) {
    if (word.contains(character)) {
      words_index.add(words_list.indexOf(word));
    }
  }

  return words_index;
}

void main() {
  final stop_watch = Stopwatch();

  stop_watch.start();
  var result = solution(["perl", "raku", "python"], "p");
  stop_watch.stop();

  print("Result: ${result}");
  print("Time taken: ${stop_watch.elapsed.inSeconds} s");
}
