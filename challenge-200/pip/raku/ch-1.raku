#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #1 of Week #200 - Pip Stuart
# Arithmetic Slices: Given an array of integers. Write a script to find out all Arithmetic Slices for the given array of integers.
#   An integer array is called arithmetic if it has at least 3 elements and the differences between any three consecutive elements are the same.
# Example1:
#   In-put: @array = (1,2,3,4)
#   Output:          (1,2,3), (2,3,4), (1,2,3,4)
# Example2:
#   In-put: @array = (2)
#   Output:          () as no slice found.
# Note: I've just started learning Raku about a week ago so this is one of my first Raku scripts. I expect my code will typically resemble my probably around
#   intermediate skill-level of Perl5. Just getting stuff to work is cool but then trying to write proper Raku that diverges further is challenging;   -Pip
use v6;my $d8VS='N1ILG09J';
sub ASlc {my @aray=@_;my @slcz;
  print '(' ~ sprintf("%-7s",join(',',@aray)) ~ ') => ';
  loop   (my Int $i=   0;$i < @aray.elems-2;$i++) {
    if   ( @aray[$i+1]-@aray[$i] == @aray[$i+2]-@aray[$i+1] ) {
      @slcz.push( "(@aray[$i],@aray[$i+1],@aray[$i+2])" );
      my $msiz=2; # start with triplets then run to end of slice
      while (@aray.elems > $i+$msiz && @aray[$i+1]-@aray[$i] == @aray[$i+$msiz]-@aray[$i+$msiz-1]) { $msiz++; }
      if ($msiz > 3) {my $slic='(' ~ @aray[$i];
        for (1..$msiz-1) { $slic ~= ',' ~ @aray[$i+$_]; }
        $slic ~= ')';
        @slcz.push($slic);
      } } }
  if    (@slcz) { say join(', ',@slcz); }
  else          { say '() as no slice found.'; }
  return(@slcz);
}
if    (@*ARGS) {
  ASlc(@*ARGS);
} else {
  ASlc(1,2,3,4); # => (1,2,3), (1,2,3,4), (2,3,4)
  ASlc(2      ); # => () as no slice found.
}
