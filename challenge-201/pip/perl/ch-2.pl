#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #2 of Week #201 - Pip Stuart
# Penny Piles: You are given an integer, $n > 0.
#   Write a script to determine the number of ways of putting $n pennies in a row of piles of ascending heights from left to right.
# Example1:
#   In-put: $n = 5
#   Output:      7  Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
#   1 1 1 1 1
#   1 1 1 2
#   1 2 2
#   1 1 3
#   2 3
#   1 4
#   5
# Last date to submit the solution 23:59 (UK Time) Sunday 29th January 2023.
use strict;use warnings;use utf8;use v5.10;my $d8VS='N1PLC2pr';my @nszs=({}, {'1'=>1}); # made global to preserve for multiple calls
sub PPil {my $numb=shift(@_);my $pilz=0; # I originally tried just merging piles with complex loops throughout the pennies but this was ultimately limited;
  for   my $size (@nszs..$numb){ # fill NumberSiZeS array of hashes up to desired $numb;          # Merged piles skipped lots but had many 1,2,4,8,16 hits;
    for my $pway (sort keys %{$nszs[$size-1]}){ # loop through all previous size pile-ways
      $nszs[$size]{"1,$pway"}=1;my @prvp=split(/,/,$pway); # prepend new 1 penny to current size
      for my $pndx (0..$#prvp){ # distribute new size layer's 1 over all the piles of the old ways
        $prvp[$pndx-1]-- if ($pndx);
        $prvp[$pndx  ]++;
        $nszs[$size]{join(',',sort {$a <=> $b} @prvp)}=1; } }
  } say join("\n",sort keys %{$nszs[$numb]});
  $pilz=scalar         keys %{$nszs[$numb]} ;
  say "$numb => $pilz;";
  return(       $pilz );
}
if    (@ARGV) {
  PPil(@ARGV);
} else { # 1,2,3=>1,2,3; 4=>5,  5=>7  ,6=>11, 7 => 15, 8 => 22, 9 => 30, 10 => 42;
  PPil( 5); # =>    7;
  PPil($_) for(1..10);
}
