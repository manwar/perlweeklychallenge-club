import "package:collection/collection.dart";

/// Solution to task 2
///
/// Title: "Sort Column"
///
/// You are given a list of strings of same length.
/// Write a script to make each column sorted lexicographically by deleting any non sorted columns.
/// Return the total columns deleted.
///
/// URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-314/
///
/// Algorithm details (TODO):
///
///    Time complexity:
///
///       - Best case scenario    : O(NM)
///       - Worst case scenario   : O(NM)
///       - Average case scenario : O(NM)
///
///    Space complexity:
///
///       - Best case scenario    : O(N)
///       - Worst case scenario   : O(N)
///       - Average case scenario : O(N)
///
///    where N = Length of the string in the list.
///          M = Number os strings.
///
/// This function takes a list of strings [string_list] and returns the number of columns [num_columns_deleted]
/// to be deleted to make each string "column" lexicographically sorted.
int solution(List<String> string_list) {
  int num_columns_deleted = 0;

  for (int idx = 0; idx < string_list[0].length; idx++) {
    List<String> temp_string_list = [];

    // Add the character for each string in a temporary list.
    for (String string in string_list) {
      temp_string_list.add(string[idx]);
    }

    // Check if that string "column" is sorted.
    if (!temp_string_list.isSorted()) {
      num_columns_deleted++;
    }
  }

  return num_columns_deleted;
}

void main() {
  final stop_watch = Stopwatch();

  stop_watch.start();
  var result = solution(["swpc", "tyad", "azbe"]);
  stop_watch.stop();

  print("Result: ${result}");
  print("Time taken: ${stop_watch.elapsed.inSeconds} s");
}
