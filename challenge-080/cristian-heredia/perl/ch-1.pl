=begin

TASK #1 › Smallest Positive Number Bits
Submitted by: Mohammad S Anwar
You are given an unsorted list of integers @N.

Write a script to find out the smallest positive number missing.

Example 1:
Input: @N = (5, 2, -2, 0)
Output: 1
Example 2:
Input: @N = (1, 8, -1)
Output: 2
Example 3:
Input: @N = (2, 0, -1)
Output: 1

=end
=cut

use strict;
use warnings;
use List::Util qw(min);

#Variables
my @N = (1, 8, -1);
my @sort = sort @N;


onlyPositive();
checkSmallest();

sub onlyPositive {
   
    foreach(my $i=0; $i<@sort; $i++) {
        if ($sort[$i] < 0) {
            splice @sort, $i, 1;
        }
    }
}

sub checkSmallest {

    my @missing = map $sort[$_-1]+1..$sort[$_]-1, 1..@sort-1;
    print "Output: ". min(@missing)."\n";

}




