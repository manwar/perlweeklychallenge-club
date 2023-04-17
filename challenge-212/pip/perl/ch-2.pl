#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #212 - Pip Stuart
# Task2: Rearrange Groups:  Submitted by: Mohammad S Anwar;  You are given a list of integers and group size greater than zero.
#   Write a script to split the list into equal groups of the given size where integers are in sequential order. If it can’t be done then print -1.
# Example1:
#   In-put: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
#   Output: (1,2,3), (1,2,3), (5,6,7)
# Example2:
#   In-put: @list = (1,2,3)             and $size = 2
#   Output: -1
# Example3:
#   In-put: @list = (1,2,4,3,5,3)       and $size = 2  # based on the expected output below, it looks like this one is supposed to be size:3
#   Output: (1,2,3), (3,4,5)
# Example4:
#   In-put: @list = (1,5,2,6,4,7)       and $size = 3
#   Output: -1
# Last date to submit the solution 23:59 (UK Time) Sunday 16th April 2023.
use strict;use warnings;use utf8;use v5.12;my $d8VS='N4GMFLUX';
sub RGrp { my @list = @_;my $size = pop(@list);my @slst = sort { $a <=> $b } @list;my @grpz = ();my $nfgf = 0;my %icnt = ();
  printf("list:(%-17s) size:$size => ", join(',', @list));
  if    (@slst % $size) { say '-1;';return(-1); }
  for   (@slst) { $icnt{$_}++; } # count each integer in the sorted list
  while (@slst) { my $strt = $slst[0];push(@grpz, []);
    for (0..$size-1) { # looping backwards by subtracting $_ since best to loop backwards when splicing below
      if (       exists($icnt{$strt + ($size-1) - $_}) && $icnt{$strt + ($size-1) - $_}) { $icnt{$strt + ($size-1) - $_}--;
        unshift(@{$grpz[-1]}, $strt + ($size-1) - $_ );
        for my $lndx (0..$#slst) { # also looping backwards so that largest of size groups are removed first (which might not be necessary?)
          if (     $slst[$#slst - $lndx] ==                     $strt + ($size-1) - $_ ) { splice(@slst, $#slst - $lndx, 1);last; } }
      } else            { say '-1;';return(-1); } } } # failed to find complete group of size beyond start
  for   (@grpz) { if ($nfgf) { print ', '; } else { $nfgf = 1; } # test the NotFirstGroupFlag to print commas between groups
    print '(' . join(',', @{$_})   . ')' ; }  say ';';
  return(@grpz);
}
if    (@ARGV) {
  RGrp(@ARGV);
} else {
  RGrp(1,2,3,5,1,2,7,6,3, 3); # => (1,2,3), (1,2,3), (5,6,7);
  RGrp(1,2,3            , 2); # => -1;
  RGrp(1,2,3            , 3); # => (1,2,3);             # Note: added test size:3 since this produces group!;
  RGrp(1,2,4,3,5,3      , 2); # => -1;                  # Note: (1,2), (3,4), (3,5) fails on the last group!;
  RGrp(1,2,4,3,5,3      , 3); # => (1,2,3), (3,4,5);    #*Note:*changed to size:3 to produce expected output;
  RGrp(1,5,2,6,4,7      , 3); # => -1;
  RGrp(1,5,2,6,4,7      , 2); # => (1,2), (4,5), (6,7); # Note: added test size:2 since this produces groups;
}
