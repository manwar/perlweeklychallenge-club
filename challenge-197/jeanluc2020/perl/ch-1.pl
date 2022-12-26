#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-197/#TASK1
#
# You are given a list of integers, @list.
#
# Write a script to move all zero, if exists, to the end while maintaining the relative order of non-zero elements.

use strict;
use warnings;

# sample input values
my $inputs = [
    [1, 0, 3, 0, 0, 5],
    [1, 6, 4],
    [0, 1, 0, 2, 0]
];

# handle all input arrays from sample list above
foreach my $input (@$inputs) {
   print "(" . join(", ", @$input) . ") returns (" . join(", ", move_zero(@$input)) . ")\n";
}

# given a list of integers, return the same list with all zeros moved to the end
sub move_zero {
   my @values = @_;
   my @return = ();
   my @tmp = ();
   # collect all non-zero values into @return, all zero values into @tmp
   foreach my $elem (@values) {
      if($elem == 0) {
         push @tmp, $elem;
      } else {
         push @return, $elem;
      }
   }
   # add all zero values to the end of @return before returning
   push @return, @tmp;
   return @return;
}
