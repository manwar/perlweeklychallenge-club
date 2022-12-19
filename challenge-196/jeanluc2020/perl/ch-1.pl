#!/usr/bin/perl
use strict;
use warnings;

# put all examples into an array
my $lists = [
   [3, 1, 4, 2],
   [1, 2, 3, 4],
   [1, 3, 2, 4, 6, 5],
   [1, 3, 4, 2],
   [],
   [1, 2]
];

# iterate over all examples and get the results, then print them
foreach my $list (@$lists) {
   my @result = pattern_132(@$list);
   print "(" . join(", ", @$list) . ") returns (" . join(", ", @result) . ")\n";
}

# function to get the output for a given list
sub pattern_132 {
   my @list = @_;
   my $last = $#list; # get index of last element
   # by iterating $i from 0 to $last, $j from $i+1 to $last and $k from $j+1 to
   # $last, we have $i<$j<$k automatically.
   foreach my $i (0..$last) {
      foreach my $j ($i+1..$last) {
         foreach my $k ($j+1..$last) {
            # if both $list[$i] < $list[$k] and $list[$k] < $list[$j] we have
            # found the first solution, so return it since we're done
            return  ($list[$i], $list[$j], $list[$k]) if $list[$i] < $list[$k] && $list[$k] < $list[$j];
         }
      }
   }
   return ();
}
