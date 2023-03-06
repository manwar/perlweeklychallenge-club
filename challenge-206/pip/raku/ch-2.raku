#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #206 - Pip Stuart
# Task2: Array Pairings:  Submitted by: Mohammad S Anwar;  You are given an array of integers having even number of elements.
#   Write a script to find the maximum sum of the minimum of each pairs.
# Example1:
#   In-put: @array = (1,2,3,4)
#   Output:               4    Possible Pairings are as below:
#     a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
#     b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
#     c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
#   So the maximum sum is 4.
# Example2:
#   In-put: @array = (0,2,1,3)
#   Output:               2    Possible Pairings are as below:
#     a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
#     b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
#     c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
#   So the maximum sum is 2.
# Last date to submit the solution 23:59 (UK Time) Sunday 5th March 2023.
use v6;my $d8VS='N35L6Who';my @para=();my %sumz=();
sub APrz {my @aray = @_; # recursively loop through all possible pairs
  if     (!(@aray % 2)) {my $parz; # don't really need this pairz since TempARrAy below tracks removed pairs
    for  1 .. (@aray.elems-1) -> $andx {$parz = '';my @tara = @aray;
      my $frst = shift (@tara); # pair up first value with each of the remaining values
      my $scnd = splice(@tara, $andx - 1, 1);
      push(@para,"$frst,$scnd"); # track pair progress
      $parz   ~= @para[*-1];
      if (@tara) { $parz ~= APrz(@tara); } # recurse...
      else       {my $psum = 0; # no pairs left so compute max sum of min of each pair
        for  @para  {($frst,$scnd) = split(',', $_, :skip-empty);
          $psum += ($frst < $scnd) ?? $frst !! $scnd; }
        %sumz{$psum} = join(' ', @para);
#       say "@para[] => $psum;"; # this will print every set of pairs with their sum
      }; pop (@para);
    }; return($parz); } }
sub MSMP {my @aray = @_;my $msmp = 0; # Max Sum of Min of Pairs
  if     (!(@aray % 2)) {@para=();%sumz=(); # make sure there's an even number of elements to pair
    APrz(@aray);
    my @srts = sort +*, keys(%sumz);
    $msmp = @srts[*-1]; } # get Max Sum from last element of numerically sorted sumz
  printf("(%-7s) => %d;\n", join(',', @aray), $msmp);
  return($msmp); }
if    (@*ARGS) {
  MSMP(@*ARGS);
} else {
  MSMP(1,2,3,4); # => 4;
  MSMP(0,2,1,3); # => 2;
}
