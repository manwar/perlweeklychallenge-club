#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an array of integers. Write a script to find out if removing ONLY one integer makes it strictly increasing order.
Example 1 Input: @ints = (0, 2, 9, 4, 6) Output: true
Removing ONLY 9 in the given array makes it strictly increasing order.
Example 2 Input: @ints = (5, 1, 3, 2) Output: false
Example 3 Input: @ints = (2, 2, 3) Output: true
=cut



use List::Util qw(uniq);
use Scalar::Util qw(dualvar);
use Test2::V0;


sub remove_one
{
     my @arr = @_;
     my @idx = 0 .. $#arr;
     for my $i ( @idx )
     {
           my @cand = @arr[grep {$_ != $i} @idx];
           if ( join(" ", @cand) eq join(" ", sort {$a <=> $b } uniq @cand )  )
           {
               return dualvar( $arr[$i], 'true' );
           }
     }
     return 'false';
}

is(remove_one(0, 2, 9, 4, 6), 'true', 'Example 1');
is(remove_one(5, 1, 3, 2), 'false', 'Example 2');
is(remove_one(2, 2, 3), 'true', 'Example 3');
done_testing();