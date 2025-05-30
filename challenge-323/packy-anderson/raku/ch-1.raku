#!/usr/bin/env raku
use v6;

sub incDec(@operations) {
  my ($x, $old_x, $o) = (0, 0, q{});
  my @explain;
  for @operations -> $op {
    ($x, $o) = ($op ~~ /\+\+/) ?? ($x + 1, '+') !! ($x - 1, '-');
    @explain.push(
      sprintf 'Operation "%s" => %2d %s 1 => %2d',
                         $op, $old_x, $o, $x
    );
    $old_x = $x;
  }
  return ($x, @explain.join("\n"));
}

sub solution(@operations) {
  say 'Input: @operations = ("' ~ @operations.join('", "') ~ '")';
  my ($output, $explain) = incDec(@operations);
  say "Output: $output\n\n$explain";
}

say "Example 1:";
solution(["--x", "x++", "x++"]);

say "\nExample 2:";
solution(["x++", "++x", "x++"]);

say "\nExample 3:";
solution(["x++", "++x", "--x", "x--"]);
