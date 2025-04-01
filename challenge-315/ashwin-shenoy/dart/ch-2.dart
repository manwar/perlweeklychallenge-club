/// Solution to task 2
///
/// Title: "Find Third"
///
/// You are given a sentence and two words.
/// Write a script to return all words in the given sentence that appear in sequence to the given two words.
///
/// URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-315/
///
/// Algorithm details (TODO):
///
///    Time complexity:
///
///       - Best case scenario    :
///       - Worst case scenario   :
///       - Average case scenario :
///
///    Space complexity:
///
///       - Best case scenario    :
///       - Worst case scenario   :
///       - Average case scenario :
///
/// This function takes a string [sentence] and 2 strings [first_word] & [second_word] and
/// returns all words in the given sentence that appear in sequence to the given two words.
List<String> solution(String sentence, String first_word, String second_word) {
  List<String> third_words = [];
  List<String> split_sentence = sentence
      .replaceAll(RegExp(r"\."), "")
      .split(" ");

  // Iterate over each word & identify the positions of the given 2 words. If they
  // are present, add the next word.
  for (int idx = 0; idx < split_sentence.length - 2; idx++) {
    if (split_sentence[idx] == first_word &&
        split_sentence[idx + 1] == second_word) {
      third_words.add(split_sentence[idx + 2]);
    }
  }

  return third_words;
}

void main() {
  final stop_watch = Stopwatch();

  stop_watch.start();
  var result = solution(
    "Perl is a my favourite language but Python is my favourite too.",
    "my",
    "favourite",
  );
  stop_watch.stop();

  print("Result: ${result}");
  print("Time taken: ${stop_watch.elapsed.inSeconds} s");
}
