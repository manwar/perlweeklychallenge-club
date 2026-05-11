#!/usr/bin/env perl
use v5.40;

sub rearrange($str) {
  my @words  = split " ", $str;
  my $spaces = length($str =~ s/\S+//gr);
  my $w = @words - 1;
  if ($w == 0) {
    return $words[0] . (" " x $spaces);
  }
  else {
    my $between = int($spaces / $w);
    my $end     =     $spaces % $w;
    return join(" " x $between, @words) . (" " x $end);
  }
}

sub solution($str) {
  say qq|Input: \$str = "$str"|;
  say qq|Output: "@{[rearrange($str)]}"|;
}

say "Example 1:";
solution("  challenge  ");

say "\nExample 2:";
solution("coding  is  fun");

say "\nExample 3:";
solution("a b c  d");

say "\nExample 4:";
solution("  team      pwc  ");

say "\nExample 5:";
solution("   the  weekly  challenge  ");
