#!/usr/bin/perl
# HTTPS://TheWeeklyChallenge.Org - Perl Weekly Challenge #2 of Week #197 - Pip Stuart
# Given a list of integers, perform Wiggle Sort on them. list[0] < list[1] > list[2] < list[3] ...
# Example 1:
#   In-put: @list = (1, 5, 1, 1, 6, 4)  Sorting the whole list and then toggling shift && pop works if the adjacent elements are allowed to equal each other.
#   Output:         (1, 6, 1, 5, 1, 4)  HTTPS://ZRZahid.Com/wiggle-sort has: 1,4,1,5,1,6 for this, which obeys the wiggle but is a different order.
# Example 2:
#   In-put: @list = (1, 3, 2, 2, 3, 1)
#   Output:         (2, 3, 1, 3, 1, 2)
# Still can get 2,2,2,... stuck in middle that need to move around. Probably best to start in middle of sorted and move away from middle?
# So sort the list then go middle, above, below, middle, below, above, middle... a pain. May need 3 lists for below, middle, && above.
use strict;use warnings;use utf8;use v5.10;my $d8VS='MCQLEKat';
sub WigS {my @ilst=@_;my @slst=sort {$a <=> $b} @ilst;my $medn=splice(@slst,int($#slst/2),1);my @olst=($medn);my $sorp=0;
  print '(' . sprintf("%-16s",join(', ',@ilst)) . ') => (';
  for my $i (0..($#ilst-1)){ # so now splice from middle of sorted array when previous output was not already median
    if($sorp ^= 1){if((int($#slst/2)+1) < $#slst && $slst[int($#slst/2)+1] == $medn && $medn != $olst[-1]){push(@olst,splice(@slst,int($#slst/2)+1,1));}
                   else                                                                                   {push(@olst,   pop(@slst));}}
    else          {if(                              $slst[int($#slst/2)  ] == $medn && $medn != $olst[-1]){push(@olst,splice(@slst,int($#slst/2)  ,1));}
                   else                                                                                   {push(@olst, shift(@slst));}}
  } say join(', ',@olst) . ");";
  return(@olst);
}
if(@ARGV){
  WigS(@ARGV);
}else{
  WigS(1, 5, 1, 1, 6, 4);
  WigS(1, 3, 2, 2, 3, 1);
  WigS(1, 3, 2, 2, 3, 1, 2, 3, 2, 1);
  WigS(1, 3, 2, 2, 3, 1, 2, 3, 2, 4);
}
