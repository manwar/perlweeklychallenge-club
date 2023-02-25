#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #205 - Pip Stuart
# Task1: Third Highest:  Submitted by: Mohammad S Anwar;  You are given an array of integers.
#   Write a script to find out the Third Highest if found otherwise return the maximum.
# Example1:
#   In-put: @array = (5,3,4)
#   Output: 3                  First highest is 5. Second highest is 4. Third highest is 3.
# Example2:
#   In-put: @array = (5,6)
#   Output: 6                  First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
# Example3:
#   In-put: @array = (5,4,4,3)
#   Output: 3                  First highest is 5. Second highest is 4. Third highest is 3.
use v6;my $d8VS='N2OLDI9U';
sub TdHi {my @aray = @_;my $thrd = 0;my %uniq = ();my @srtd = ();
  print '(' ~ sprintf("%-7s",join(',',@aray)) ~ ') => ';
  for (@aray) { %uniq{$_} = 1; }
  @srtd = %uniq.keys.sort;
  $thrd = @srtd[*-1] if (@srtd.elems    );
  $thrd = @srtd[*-3] if (@srtd.elems > 2);
  say    $thrd ~ ';';
  return($thrd);
}
if    (@*ARGS) {
  TdHi(@*ARGS);
} else {
  TdHi(5,3,4  ); # => 3
  TdHi(5,6    ); # => 6
  TdHi(5,4,4,3); # => 3
}
