import "dart:math";

/// Solution to task 1
///
/// Title: "Equal Strings"
///
/// You are given three strings.
/// You are allowed to remove the rightmost character of a string to make all equals.
/// Write a script to return the number of operations to make it equal otherwise -1.
///
/// URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-314/
///
/// Algorithm details:
///
///    Time complexity:
///
///       - Best case scenario    : O(N)
///       - Worst case scenario   : O(N)
///       - Average case scenario : O(N)
///
///    Space complexity:
///
///       - Best case scenario    : O(1)
///       - Worst case scenario   : O(1)
///       - Average case scenario : O(1)
///
/// This function takes 3 strings [s1], [s2] & [s3] & returns the count [num_operations] for the
/// number of operations required to make the equal by removing the right most character.
int solution(String s1, String s2, String s3) {
  int num_operations = 0;
  int max_length = max(max(s1.length, s2.length), s3.length);

  // Loop through each string and keep "popping" the last element (if it exists).
  for (int idx = max_length; idx > 0; idx--) {
    if (s1.length >= idx) {
      s1 = s1.replaceRange(idx - 1, idx, "");
      num_operations++;
    }

    if (s2.length >= idx) {
      s2 = s2.replaceRange(idx - 1, idx, "");
      num_operations++;
    }

    if (s3.length >= idx) {
      s3 = s3.replaceRange(idx - 1, idx, "");
      num_operations++;
    }

    // Return the number of operations if all 3 strings are equal, but not
    // empty strings.
    if (s1 == s2 && s2 == s3 && s1 != "" && s2 != "" && s3 != "") {
      return num_operations;
    } else {
      continue;
    }
  }

  // At this point, the strings aren't equal (even after removing all characters).
  return -1;
}

void main() {
  final stop_watch = Stopwatch();

  stop_watch.start();
  var result = solution("ayz", "cyz", "xyz");
  stop_watch.stop();

  print("Result: ${result}");
  print("Time taken: ${stop_watch.elapsed.inSeconds} s");
}
