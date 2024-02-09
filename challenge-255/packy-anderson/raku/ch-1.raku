#!/usr/bin/env raku
use v6;

sub oddChar($s, $t) {
  # count the characters in $s
  my %count;
  for $s.lc.split('', :skip-empty) -> $c {
    %count{$c}++;
  }
  # find the character in $t that's been added to $s
  for $t.lc.split('', :skip-empty) -> $c {
    if ( %count{$c}:!exists ) {
      # we found the added character!
      return $c
    }
    %count{$c}--;
    %count{$c}:delete if %count{$c} == 0;
  }
  die "No odd character found!";
}

sub solution($s, $t) {
  say qq/Input: \$s = "$s" \$t = "$t"/;
  my $o = oddChar($s, $t);
  say qq/Output: "$o"/;
}

say "Example 1:";
solution("Perl", "Preel");

say "\nExample 2:";
solution("Weekly", "Weeakly");

say "\nExample 3:";
solution("Box", "Boxy");