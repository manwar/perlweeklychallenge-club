#!/usr/env/perl
# Task 2 Challenge 055 Solution by saiftynet
# Wave Array
# Any array N of non-unique, unsorted integers can be arranged into 
# a wave-like array such that n1 ≥ n2 ≤ n3 ≥ n4 ≤ n5 and so on.
# For example, given the array [1, 2, 3, 4], possible wave arrays 
# include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 ≥ 1 ≤ 4 ≥ 3 and 
# 4 ≥ 1 ≤ 3 ≥ 2. This is not a complete list.
# Write a script to print all possible wave arrays for an integer 
# array N of arbitrary length.
# Notes:When considering N of any length, note that the first element 
# is always greater than or equal to the second, and then the ≤, 
# ≥, ≤, … sequence alternates until the end of the array.


use strict;use warnings;
my @list=(3,1,4,5);

# Notes The list may contain repeated numbers. The wavinesss
# requirement for the task is that the first pair is descending

# Sequence builder.  This builds a set of @results.  Each result
# contains two lists, one the sequence that is being assembled, and one
# that# contains elements that have not yet been used.  Initially
# there are no sequences built, and all the list elements are available.
# Two circular lists are used rather than keeping an index, shifting
# from one end and pushing to the other.  For sequences that contain
# duplicate values, no attempt is made to remove duplicate sedquences 
# that may be found as a result.

my @results=([[],[@list]]);
while (1){
   my $res=$results[0];
   my @rest=@{$res->[1]};    # extract sequence
   my @seq= @{$res->[0]};    # extract potential next elemenets
   last unless @rest;        # exit loop when no more elements left 
   foreach (1..@rest){       # for each of the potential elements
      my $next=shift @rest; 
      push @results,[[@seq,$next],[@rest]] # add sequence and remnant to result
      if wavy2(@seq,$next) eq "Down first";  # but only if the result is wavy
          push @rest,$next;     # rotate the remnant list
      }
      shift @results;           # rotate the results
}

# print out the sequences found
print "The list ( ".join (", ",@list). " ) can be made to form the following wavy lists: -\n";
foreach my $res (@results){
   print join  (",",@{$$res[0]}),"\n";
}

# phase detector: detects whether the sequence is oscillating throughout length
# and whether the wave first transition is negative or positive.  It ignores
# consecutive equal values, as long as phase is maintained afterwards
#  4      2      7      6        6         6      9      1
#    down    up    down    equal    equal     up     down      = Acceptable
#
#  4      2      7      6        6         6      1      9
#    down    up    down   equal      equal     down   up       =  Not Acceptable
# simply comparing adjacent values may fail when there are three or more consecutive
# equal values

sub wavy2{
  my @seq=@_;
  my ($evenUp,$evenDown,$oddUp,$oddDown);
  foreach my $i (1..$#seq){
    if ($i%2){                      # phases are even or odd, up going or down going
       $evenUp=1   if ($seq[$i]>$seq[$i-1]);
       $evenDown=1 if ($seq[$i]<$seq[$i-1]);
    }
    else{
       $oddUp=1   if ($seq[$i]>$seq[$i-1]);
       $oddDown=1 if ($seq[$i]<$seq[$i-1]);
    }
    # wavy phases have the even pahases only going one way and the odd phases
    # in the opposite direction
    return "Not wavy" if ($evenUp   and $evenDown) ||
                         ($oddUp    and $oddDown)  ||
                         ($evenUp   and $oddUp)    ||
                         ($evenDown and $oddDown);
  }
  return $evenUp?"Up first":"Down first";  # returns "Up first", "Down first" or "Not wavy"
}


