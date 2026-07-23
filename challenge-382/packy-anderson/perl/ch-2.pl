#!/usr/bin/env perl
use v5.40;

sub nums($n) {
  my @nums;
  for my $i (0 .. (2**$n - 1)) {
    push @nums, sprintf "%0*b", $n, $i;
  }
  @nums;
}

sub replaceQuestionMark($str) {
  # how many question marks
  my $marks = scalar(@{[ $str =~ /\?/g ]});
  # trivial case: no question marks
  return $str if $marks == 0;
  # produce all the combinations
  my @output;
  for my $bits ( nums($marks) ) {
    my @b = split //, $bits;
    push @output, $str =~ s/\?/shift @b/ger;
  }
  @output
}

sub solution($str) {
  say qq/Input: \$str = "$str"/;
  my @output = map { qq/"$_"/ } replaceQuestionMark($str);
  say 'Output: (' . join(', ', @output) . ')';
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
