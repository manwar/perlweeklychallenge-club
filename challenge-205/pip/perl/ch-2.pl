#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #205 - Pip Stuart
# Task2: Maximum XOR:  Submitted by: Mohammad S Anwar;  You are given an array of integers.
#   Write a script to find the highest value obtained by XORing any two distinct members of the array.
# Example1:
#   In-put: @array = (1,2,3,4,5,6,7)
#   Output:  7                       The maximum result of 1 xor 6 = 7.
# Example2:
#   In-put: @array = (2,4,1,3)
#   Output:  7                       The maximum result of 4 xor 3 = 7.
# Example3:
#   In-put: @array = (10,5,7,12,8)
#   Output: 15                       The maximum result of 10 xor 5 = 15.
# Last date to submit the solution 23:59 (UK Time) Sunday 26th February 2023.
use strict;use warnings;use utf8;use v5.12;my $d8VS='N2OLDC2q';
sub Mxor {my @aray = @_;my $mxor = 0;my %maxr = ();my @srtd = (); # need to force string params into numbers below
  if     ( @aray) {
    for              (    0 ..($#aray-1)) { $aray[$_   ] = 0+$aray[$_   ];
      if ($#aray) {
        for my $scnd (($_+1).. $#aray   ) { $aray[$scnd] = 0+$aray[$scnd];
          my    $xor2   =  $aray[$_]^$aray[$scnd];
          $maxr{$xor2} .= "$aray[$_]^$aray[$scnd]; "; } } } }
  @srtd = sort { $a <=> $b } keys(%maxr);
  print '(' . sprintf("%-13s",join(',',@aray)) . ') => ';
  $mxor = $srtd[-1] if (@srtd && exists($maxr{$srtd[-1]}));
  say    $mxor . ';';
  return($mxor);
}
if    (@ARGV) {
  Mxor(@ARGV);
} else {
  Mxor(1,2,3,4,5,6,7); # =>  7;
  Mxor(2,4,1,3      ); # =>  7;
  Mxor(10,5,7,12,8  ); # => 15;
}
