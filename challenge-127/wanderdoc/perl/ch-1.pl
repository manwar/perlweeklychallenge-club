#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two sets with unique integers.

Write a script to figure out if they are disjoint.

    The two sets are disjoint if they don't have any common members.

Example

Input: @S1 = (1, 2, 5, 3, 4)
       @S2 = (4, 6, 7, 8, 9)
Output: 0 as the given two sets have common member 4.

Input: @S1 = (1, 3, 5, 7, 9)
       @S2 = (0, 2, 4, 6, 8)
Output: 1 as the given two sets do not have common member.
=cut





use List::Util qw(uniq);

sub check_sets
{
     my ($aref_1, $aref_2) = @_;
     return (scalar @$aref_1 + scalar @$aref_2 == uniq(@$aref_1, @$aref_2)) ? 
          1 : 0;
}

print check_sets([1,2,3,5,4], [4,6,7,8,9]), $/;
print check_sets([1,3,5,7,9], [0,2,4,6,8]), $/;