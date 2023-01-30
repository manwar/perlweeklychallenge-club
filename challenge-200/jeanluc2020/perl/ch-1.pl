#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-200/#TASK1
#
# You are given an array of integers.
#
# Write a script to find out all Arithmetic Slices for the given array of integers.
#
####  An integer array is called arithmetic if it has at least 3 elements and the differences between any three consecutive elements are the same.
#
#
### Example 1
###
### Input: @array = (1,2,3,4)
### Output: (1,2,3), (2,3,4), (1,2,3,4)
#
### Example 2
###
### Input: @array = (2)
### Output: () as no slice found.

####################################################################
##
## discussion
##
####################################################################
##
## This task contains two parts:
## - find all slices of a given array with at least 3 elements
## - for each of those slices, check whether it is arithmetic
##
## In order to find all slices, we have multiple possibilities. One would be
## to walk through the array, creating all possible slices, storing them in
## an array and returning that. Another one would be to have an iterator:
## basically a function that "remembers" which slices it has already produced
## and when being called will just return the next slice. While the former is
## easier to implement, the latter works better when walking through a huge
## array where storing all slices at once would require a lot of memory.
## This also has an performance impact (even though one might argue this
## doesn't really matter: on my system, the difference of solution 1
## (1.154261 seconds) to solution 2 (0.632249 seconds) is roughly half a second
## for all 4 examples (one of which includes 200 elements in the array), but
## that's also almost a factor of 2 (but much of that is the time printing
## all of the solutions to the terminal). By removing the printing, this
## changes to 0.591356 seconds for solution 1 and 0.19912 seconds for solution
## 2; that is almost a factor of 3 at just 200 elements in the array.
## Furthermore, I get "deep recursion" warnings when running solution 1 with an
## array of 200 elements while this doesn't happen with the iterator solution

use strict;
use warnings;
use Time::HiRes qw(gettimeofday tv_interval);

my @examples = (
   [1, 2, 3, 4],
   [2],
   [1, 2, 3, 4, 6],
   [1..200]
);

my $t0 = [ gettimeofday() ];

print "create all slices first, then keep the arithmetic ones\n";
foreach my $array (@examples) {
   print "Array: (" . join(",", @$array) . ")\n";
   # get all the slices first
   my @slices = make_slices(@$array);
   # only keep the arithmetic ones
   my @result = grep { is_arithmetic($_, 0, scalar(@$_)-1) } @slices;
   if(@result) {
      my $first = 1;
      foreach my $elem (@result) {
         print ", " unless $first;
         $first = 0;
         print "(" . join(",", @$elem) . ")";
      }
      print "\n";
   } else {
      print "()\n";
   }
}
my $elapsed = tv_interval ( $t0, [gettimeofday()]);

# given an array, return all slices
sub make_slices {
   my @array = @_;
   my @result = ();
   return () unless $#array >= 2;
   # first add all slices that start at position 0
   foreach my $i (2..$#array) {
      push @result, [ @array[0..$i] ];
   }
   # then add all slices recursively that start at
   # later positions
   push @result, make_slices(@array[1..$#array]);
   return @result;
}

$t0 = [ gettimeofday() ];
print "use an iterator\n";
# now a solution with an iterator
foreach my $array (@examples) {
   my $found = 0;
   print "Array: (" . join(",", @$array) . ")\n";
   # get an iterator. This is a function that returns on
   # slice on each call until all slices are produced, at
   # which time it returns undef
   my $iterator = make_iterator($array);
   # call the iterator for the first time. It returns a
   # reference to the array and the index of the first
   # and last element of the current slice inside this array
   my ($arr, $first_index, $last_index) = $iterator->();
   # catch the case of an empty result
   if($arr) {
      # while we still get slices out of the iterator:
      while(@$arr) {
         # if we have an arithmetic slice, we print it
         if(is_arithmetic($arr, $first_index, $last_index)) {
            print ", " if $found;
            $found++;
            print "(";
            foreach my $i ($first_index..$last_index) {
               print "$arr->[$i]";
               print "," unless $i == $last_index;
            }
            print ")";
         }
         # get the next element from the iterator for the next
         # run of the while loop; since this returns an empty
         # array once the iterator has produced all slices, the
         # while loop will terminate
         ($arr, $first_index, $last_index) = $iterator->();
      }
      print "\n";
   } else {
      print "()\n";
   }
}

my $elapsed2 = tv_interval ( $t0, [gettimeofday()]);

print "Solution 1 took $elapsed seconds; solution 2 took $elapsed2 seconds\n";

# the iterator generating function. It returns a reference to an
# anonymous function the returns the next slice as long as there are
# further slices; otherwise it returns an empty array
sub make_iterator {
   my $array = shift;
   # we declare the necessary variables here. They can be used in
   # the anonymous function that we return and keep their values between
   # calls so we can use them to iterate over the indices inside the
   # array
   my ($i, $j) = (0, 2);
   return sub {
      # once the second index variable reached the end of the array,
      # restart with the first index variable incremented and the
      # second index variable starting out two elements later in the
      # array to produce slices of minumum length 3.
      if($j >= scalar(@$array)) {
         $i++;
         $j=$i+2;
         # if the second index variable is already higher than the
         # highest index in the array, we can't produce any more
         # slices and return the empty array as a result
         return ([], undef, undef) if $j >= scalar(@$array);
      }
      # return the current slice and increment the second index variable
      # right after that so that it's already in the right place next time
      # the iterator is being called
      return ($array, $i, $j++);
   };
}

# helper function to check whether a slice of a given array is arithmetic
# expects 3 arguments: array ref, first index to consider inside that
# array, and last index to consider in that array
# the reason we need the first and last index is that the iterator based
# solution always hands in the whole array without any copying, so we
# need to know where the slice we want to examine starts and where it ends
sub is_arithmetic {
   my ($array, $first_index, $last_index) = @_;
   return undef if $last_index - $first_index < 2;
   my $diff = $array->[$first_index+1] - $array->[$first_index];
   foreach my $i ($first_index..$last_index-1) {
      if($diff != ($array->[$i+1] - $array->[$i]) ) {
         return undef;
      }
   }
   return 1;
}
