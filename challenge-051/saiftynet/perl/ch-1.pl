#!/usr/env/perl
# Task 1 Challenge 051 Solution by saiftynet
# 3 Sum
# Given an array @L of integers. Write a script to find all unique 
# triplets such that a + b + c is same as the given target T. Also 
# make sure a <= b <= c.
# Here is wiki page for more information.
# Example:
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

use strict;use warnings;

# one key word in this task appears to be the word "unique". So if list
# contains duplicated elements one should not generate identical triplets.
# The task list has been modified therefore to test duplicate rejection

my @L = (-25, -10, -7, -3, -3, 2, 4, 8, 10, -7);
my $T=0;

findTriplet($T,@L);                 # function called with target and list
 
sub findTriplet{
  my ($target,@list)=@_; 
  @list=sort{$a<=>$b} @list;         # the list may not be sorted, so sort first
  my @found=();                      # initialise list triplets found
  foreach my $i(0..$#list-2){        # first number cannot be the last two numbers in the list
    foreach my $j($i+1..$#list-1) {  # second number bigger than first but can not be last number
      foreach my $k($j+1..$#list){   # third number bigger than second in list
		  
		                             # check for triplet and if found add triplet to @found
      unshift @found,[$list[$i],$list[$j],$list[$k]]
                if $list[$i]+$list[$j]+$list[$k]==$target;
      
      no warnings;  # smartmatch is experimental:  suppress warnings
      # dump duplicates using smartmatch (only check if 2 or more triplets found)
      shift @found if (@found>=2 and @{$found[0]}~~@{$found[1]});
      }
    }
  };
  if (@found){
    print  scalar @found," Triplets found\n";
    foreach my $triple(@found){
      print "[ $$triple[0], $$triple[1], $$triple[2] ] "
    }
  }  
  else{ 
    print  "No Triplet found that add to $target\n"
  };
}

