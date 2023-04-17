#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-212/#TASK2
#
# Task 2: Rearrange Groups
# ========================
#
# You are given a list of integers and group size greater than zero.
#
# Write a script to split the list into equal groups of the given size where
# integers are in sequential order. If it can’t be done then print -1.
#
## Example 1:
##
## Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
## Output: (1,2,3), (1,2,3), (5,6,7)
#
## Example 2:
##
## Input: @list = (1,2,3) and $size = 2
## Output: -1
#
## Example 3:
##
## Input: @list = (1,2,4,3,5,3) and $size = 3
## Output: (1,2,3), (3,4,5)
#
## Example 4:
##
## Input: @list = (1,5,2,6,4,7) and $size = 3
## Output: -1
#
############################################################
##
## discussion
##
############################################################
#
# We can basically sort the elements of the array, then always try
# to (group size) elements from that array starting at the smallest
# element. If we can always do that, we return those results. If we
# can't in any point, we can return -1.
# In order to make this easier, we can count each element and keep the
# count in a hash table the keys of which equate the elements from the
# original list and the value is the count of this element in that
# list.

use strict;
use warnings;
use List::Util qw(min);

rearrange_groups([1,2,3,5,1,2,7,6,3], 3);
rearrange_groups([1,2,3], 2);
rearrange_groups([1,2,4,3,5,3], 3);
rearrange_groups([1,5,2,6,4,7], 3);
rearrange_groups([1,5,2,6,4,7], 2);

sub rearrange_groups {
   my ($list, $size) = @_;
   print "Input: (" . join(",", @$list) . "); $size\n";
   my $data;
   # count all elements into the hash %$data
   foreach my $elem (@$list) {
      $data->{$elem}++;
   }
   # start with the minimum key
   my $min = min(keys(%$data));
   my @result = ();
   # as long as there is still some data
   while(defined($min)) {
      my @tmp = ();
      # find up to "size" sequential elements
      foreach my $cur (0..$size-1) {
         if($data->{$min+$cur}) {
            # if there is such an element, add it to our
            # current temporary sub-result, decrease the
            # counter in this hash element, and remove
            # the element from the hash altogether if it
            # was the last for this key.
            push @tmp, ($min+$cur);
            $data->{$min+$cur}--;
            delete $data->{$min+$cur} unless $data->{$min+$cur};
         } else {
            # not enough sequential elements found, we're done here
            print "Output: -1\n";
            return;
         }
      }
      # OK, we found one result set to put on our result, then
      # we can continue with the new minimum key in the hash
      push @result, [ @tmp ];
      $min = min(keys(%$data));
   }
   # Let's output the result that we found
   print "Output: ";
   my $first = 1;
   foreach my $arr (@result) {
      print ", " unless $first;
      print "(" . join(",", @$arr) . ")";
      $first = 0;
   }
   print "\n";
}

