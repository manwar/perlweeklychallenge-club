#! /usr/bin/perl
#  PWCC 191 P1: "Twice Largest"

=pod

Task 1: Twice Largest
Submitted by: Mohammad S Anwar

You are given list of integers, @list.

Write a script to find out whether the largest item in the list
is at least twice as large as each of the other items.

Example 1                         Example 2
Input: @list = (1,2,3,4)          Input: @list = (1,2,0,5)
Output: -1                        Output: 1

Example 3                         Example 4
Input: @list = (2,6,3,1)          Input: @list = (4,5,2,3)
Output: 1                         Output: -1

=cut

# NOTE: Input is either from a hard-coded array of arrays, or from
#       a single array given by space-separated command-line arguments.

# NOTE: Output is to stdout and will consist of
#       each input array followed by an arrow
#       and 1 (if largest element is at least  twice each of the others)
#       or -1 (if largest element is less than twice any  of the others).

use v5.36;

# Set item separator to "," for printing arrays:
$, = ',';

# Default inputs:
my @arrays = ( [1,2,3,4] , [1,2,0,5] , [2,6,3,1] , [4,5,2,3] );

# Non-default input (one array only, via space-separated command-line arguments:
if (@ARGV) {@arrays = ( [@ARGV] );}

for my $ar (@arrays)
{
   my @array = reverse sort {$a <=> $b} @$ar and my $twice = 1;
   $array[0] < 2 * $_ and $twice = -1 and last for @array[1..$#array];
   print "("; print @$ar; print ") -> "; printf("%2d",$twice); print "\n";
}
exit;
__END__
