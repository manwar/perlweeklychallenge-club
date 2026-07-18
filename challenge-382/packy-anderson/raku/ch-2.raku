#!/usr/bin/env raku
use v6;

sub nums($n) {
  my @nums;
  for (0 .. (2**$n - 1)) -> $i {
    @nums.push: sprintf "%0*b", $n, $i;
  }
  @nums;
}

sub replaceQuestionMark($str) {
  # how many question marks
  my $marks = $str.comb(/\?/).elems;
  # trivial case: no question marks
  return [$str] if $marks == 0;
  # produce all the combinations
  my @output;
  for nums($marks) -> $bits {
    my @b = $bits.comb;
    @output.push: $str.subst(/\?/, { @b.shift }, :g);
  }
  @output
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my @output = replaceQuestionMark($str).map({ qq/"$_"/ });
  say 'Output: (' ~ @output.join(', ') ~ ')';
}

say "Example 1:";
solution("01??0");

say "\nExample 2:";
solution("101");

say "\nExample 3:";
solution("???");

say "\nExample 4:";
solution("1?10");

say "\nExample 5:";
solution("1?1?0");
