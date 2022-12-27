#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-197/#TASK2
#
# You are given a list of integers, @list.
#
# Write a script to perform Wiggle Sort on the given list.
#
# # Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]...

use strict;
use warnings;

# sample input values
my $inputs = [
   [1,5,1,1,6,4],
   [1,3,2,2,3,1],
   [1,2,3,4,5],
   [1,1,1,2,2,2,3,3,4,4],
];

# handle all input arrays from sample list above
foreach my $input (@$inputs) {
   print "(" . join(", ", @$input) . ") returns (" . join(", ", wiggle_sort(@$input)) . ")\n";
}

# wiggle sort has to jump up and down every time
sub wiggle_sort {
   # let's start by sorting all values
   my @values = sort {$a <=> $b} @_;
   my @result = ();
   # by starting in the middle of the sorted array and walking down while at
   # the same time starting at the top and wakling down as well, we can always
   # make sure we have a bigger and a smaller value next to each other
   my $start = int($#values/2);
   my ($i, $j) = ($start, $#values);
   while($i >= 0 && $j > $start) {
      push @result, $values[$i--], $values[$j--];
   }
   # if we have an odd number of values in the original array, we now have
   # one more value to take care of; in this case $i just reached 0 by means of
   # the last "$i--" in the loop
   push @result, $values[$i] if $i == 0;
   return @result;
}
