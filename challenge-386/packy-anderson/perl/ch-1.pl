#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( sum zip_by );

# map chars => values like 'A' => 10, 'a' => 37
my %chars = zip_by { $_[0] => $_[1] }
  [0...9,'A'...'Z','a'...'z','+','/'], [0..63];

sub reverseBase($num, $base) {
  my $p = 0;         # start with $base ** 0
  sum                # add it all up
  map { ($base ** $p++) * $_ } # multiply by power
  reverse            # reverese the string so place -> power
  map { $chars{$_} } # map character to numeric equivalent
  split //, $num;    # break the number into digits
}

sub solution($num, $base) {
  say qq/Input: \$num = "$num", \$base = $base/;
  say qq/Output: @{[reverseBase($num, $base)]}/;
}

say "Example 1:";
solution("101010", 2);

say "\nExample 2:";
solution("EEADEE", 16);

say "\nExample 3:";
solution("755", 8);

say "\nExample 4:";
solution("1BRJB", 36);

say "\nExample 5:";
solution("7MyqL", 64);
