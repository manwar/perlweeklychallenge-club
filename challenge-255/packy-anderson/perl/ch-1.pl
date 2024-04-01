#!/usr/bin/env perl
use v5.38;

sub oddChar($s, $t) {
  # count the characters in $s
  my %count;
  foreach my $c ( split(//, lc($s)) ) {
    $count{$c}++;
  }
  # find the character in $t that's been added to $s
  foreach my $c ( split(//, lc($t)) ) {
    if ( ! exists $count{$c} ) {
      # we found the added character!
      return $c
    }
    $count{$c}--;
    delete $count{$c} if $count{$c} == 0;
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