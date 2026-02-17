#!/usr/bin/env perl
use v5.40;

sub justify($str, $width) {
  my $len = length($str);
  # handle special cases
  if ($len >= $width) {
    return ($str, "No padding needed");
  }
  elsif ($len == 0) {
    return (
      '*' x $width, 
      "Text length = 0, Width = $width\nEntire output is padding"
    );
  }
  my $pad   = $width - $len;
  my $lside = int($pad / 2);
  my $rside = $pad - $lside;
  my $output = ('*' x $lside) . $str . ('*' x $rside);
  my $explain = "Text length = $len, Width = $width\n"
              . "Need $pad padding characters total\n"
              . "Left padding: $lside stars, "
              . "Right padding: $rside stars";
  return ($output, $explain);
}

sub solution($str, $width) {
  say qq/Input: \$str = "$str", \$width = $width/;
  my ($output, $explain) = justify($str, $width);
  say qq/Output: "$output"\n\n$explain/;
}

say "Example 1:";
solution("Hi", 5);

say "\nExample 2:";
solution("Code", 10);

say "\nExample 3:";
solution("Hello", 9);

say "\nExample 4:";
solution("Perl", 4);

say "\nExample 5:";
solution("A", 7);

say "\nExample 6:";
solution("", 5);
