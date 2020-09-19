#!/usr/bin/env perl
use 5.024;
use warnings;

# This problem is easier to tackle if moving from the *end* of the array
# back to the beginning. So, we reverse the input array to analyze it
# and then reverse it again to get back to the original order.
sub keep_leaders { # @A <=> @_
   return (0) unless @_;
   my $last_leader = $_[-1] - 1;
   return reverse grep {
      my $condition = $_ > $last_leader;
      $last_leader = $_ if $condition;
      $condition;
   } reverse @_;
}


# testing stuff
for my $Aref (
   [9, 10, 7, 5, 6, 1],
   [3, 4, 5],
   [],
) {

   printout('Input: @A = ', @$Aref);
   printout('Output: ', keep_leaders(@$Aref));
}

sub printout {
   my $prefix = shift;
   say $prefix, '(', join(', ', @_), ')'
}
