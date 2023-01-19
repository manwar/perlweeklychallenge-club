#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #1 of Week #200 - Pip Stuart
# Arithmetic Slices: Given an array of integers. Write a script to find out all Arithmetic Slices for the given array of integers.
#   An integer array is called arithmetic if it has at least 3 elements and the differences between any three consecutive elements are the same.
# Example1:
#   In-put: @array = (1,2,3,4)
#   Output:          (1,2,3), (2,3,4), (1,2,3,4)
# Example2:
#   In-put: @array = (2)
#   Output:          () as no slice found.
#
#
use strict;use warnings;use utf8;use v5.10;my $d8VS='N1HLNEko';
sub ASlc {my @aray=@_;my @slcz;
  print '(' . sprintf("%-7s",join(',',@aray)) . ') => ';
  for    (my     $i=   0;$i < @aray      -2;$i++) {
    if   ( $aray[$i+1]-$aray[$i] == $aray[$i+2]-$aray[$i+1] ) {
      push(@slcz,"($aray[$i],$aray[$i+1],$aray[$i+2])");
      my $msiz=2; # just loop from 3-leaves to longest trunk
      while (@aray > $i+$msiz && $aray[$i+1]-$aray[$i] == $aray[$i+$msiz]-$aray[$i+$msiz-1]) { $msiz++; }
      if ($msiz > 3) {my $slic='(' . $aray[$i];
        for (1..$msiz-1) { $slic .= ',' . $aray[$i+$_]; }
        $slic .= ')';
        push(@slcz,$slic);
      } } }
  if    (@slcz) { say join(', ',@slcz); }
  else          { say '() as no slice found.'; }
  return(@slcz);
}
if    (@ARGV) {
  ASlc(@ARGV);
} else {
  ASlc(1,2,3,4); # => (1,2,3), (1,2,3,4), (2,3,4)
  ASlc(2      ); # => () as no slice found.
}
