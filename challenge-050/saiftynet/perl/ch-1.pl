#!/usr/env/perl
# Task 1 Challenge 050 Solution by saiftynet
# Merge Intervals
# Write a script to merge the given intervals where ever possible.
# [2,7], [3,9], [10,12], [15,19], [18,22]
# The script should merge [2, 7] and [3, 9] together to return [2, 
# 9].
# Similarly it should also merge [15, 19] and [18, 22] together 
# to return [15, 22].
# The final result should be something like below:
# [2, 9], [10, 12], [15, 22]

# 1st part generates random intervals. Intervals are pairs of numbers.
# $start is smaller than the $end. Because these are random, they are
# also unsorted unlike the example shown above.  The merging is more
# efficient if the list is sorted.  This is similar to challenge 039
# mergeIntervals() subroutine contains the sub merge() which merges
# adjacent of intervals

use strict; use warnings;
my @list=();
foreach (0..10){                              # random interval generator
    my $start=int(80*rand());
    my $end=$start+int(10*rand()+2);
    push @list,[$start,$end];
}

print "Before Merging:-\n",                   
      (join ",",map{"[$$_[0],$$_[1]]"} @list),# Prints the initial list
       "\n"; 
@list=mergeIntervals(@list);                  # Merge the list
print "After Merging:-\n",                    
      (join ",",map{"[$$_[0],$$_[1]]"} @list),# Print the list post merger
      "\n\n"; 

# The mergeIntervals takes a list of intervals, sorts them and merges where possible
sub mergeIntervals{
  my @toMerge=sort {$$a[0]<=>$$b[0]} @_;      # sort intervals on the intervals' start
    
  my $pointer=our $merges=0;                    
  while ($pointer<$#toMerge){                 # check two adjacent intervals for merging
         splice @toMerge,$pointer,2,merge($toMerge[$pointer],$toMerge[$pointer+1]);
         $pointer++ unless $merges;           # unless merging can move to next set
         $merges=0;                           # reset merges flag
   }
  return @toMerge;
    
  sub merge{          # for sorted pair, pair will merge if start of second is
    my ($a,$b)=@_;    # less or equal to end of first. When a merge happens,
		              # start is the start of first, and end is the largest
		              # of either ends
    return ([$$a[0], $$a[1]>$$b[1]?$$a[1]:$$b[1]])
         if  $$a[1]>=$$b[0] and $merges=1;   # a merge happens and is flagged
    return ($a,$b);                          # if not merged, returns the pair
  }
}

