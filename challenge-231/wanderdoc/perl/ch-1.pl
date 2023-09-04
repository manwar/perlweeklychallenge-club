#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of distinct integers. Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.
Example 1 Input: @ints = (3, 2, 1, 4) Output: (3, 2)
The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.
Example 2 Input: @ints = (3, 1) Output: -1
Example 3 Input: @ints = (2, 1, 3) Output: (2)
The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.
=cut



use Test2::V0;
use List::Util qw(min max);


sub no_min_max
{
     my @arr = @_;
     return -1 if (scalar @arr < 3);
     my $min = min(@arr);
     my $max = max(@arr);
     @arr = grep {$_ != $min and $_ != $max} @arr;
     return @arr;
}

# print join(" ", no_min_max(2, 1, 3));

is([no_min_max(3, 2, 1, 4)], [3, 2], 'Example 1');
is([no_min_max(3, 1)], [-1], 'Example 2');
is([no_min_max(2, 1, 3)], [2], 'Example 3');
done_testing();