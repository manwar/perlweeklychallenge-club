#!/usr/bin/env raku
use v6;

sub rearrange($str) {
  my @words  = $str.comb(/\S+/);
  my $spaces = $str.comb(/\s/).elems;
  my $w = @words.elems - 1;
  if ($w == 0) {
    return @words[0] ~ (" " x $spaces);
  }
  else {
    my $between = $spaces div $w;
    my $end     = $spaces  %  $w;
    return @words.join(" " x $between) ~ (" " x $end);
  }
}

sub solution($str) {
  say qq[Input: \$str = "$str"];
  say qq[Output: "{rearrange($str)}"];
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
