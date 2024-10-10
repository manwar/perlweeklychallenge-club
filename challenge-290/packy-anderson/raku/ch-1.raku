#!/usr/bin/env raku
use v6;

sub doubleExist(@ints) {
  for 0 .. @ints.end -> $i {
    next unless @ints[$i] %% 2;
    for 0 .. @ints.end -> $j {
      next if $j == $i;
      next if @ints[$j] * 2 != @ints[$i];
      return 'true',
        "For \$i = $i, \$j = $j\n" ~
        "\$ints[\$i] = @ints[$i] => 2 * @ints[$j] => " ~
        "2 * \$ints[\$j]";
    }
  }
  return 'false';
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($answer, $explain) = doubleExist(@ints);
  say "Output: $answer";
  if ($explain) {
    say "\n$explain"
  }
}

say "Example 1:";
solution([6, 2, 3, 3]);

say "\nExample 2:";
solution([3, 1, 4, 13]);

say "\nExample 3:";
solution([2, 1, 4, 2]);
