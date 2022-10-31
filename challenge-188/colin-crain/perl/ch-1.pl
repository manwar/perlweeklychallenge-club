#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       divisibility_index.pl
#
#       Divisible Pairs
#         Submitted by: Mohammad S Anwar
#         You are given list of integers @list of size $n and divisor $k.
# 
#         Write a script to find out count of pairs in the given list that
#         satisfies the following rules.
# 
#         The pair (i, j) is eligible if and only if
#         a) 0 <= i < j < len(list)
#         b) list[i] + list[j] is divisible by k
# 
#         Example 1
#             Input: @list = (4, 5, 1, 6), $k = 2
#             Output: 2
# 
#         Example 2
#             Input: @list = (1, 2, 3, 4), $k = 2
#             Output: 2
# 
#         Example 3
#             Input: @list = (1, 3, 4, 5), $k = 3
#             Output: 2
# 
#         Example 4
#             Input: @list = (5, 1, 2, 3), $k = 4
#             Output: 2
# 
#         Example 5
#             Input: @list = (7, 2, 4, 5), $k = 4
#             Output: 1
# 
# 
#         method:
# 
#             What is it we are asking for here, anyways? Perhaps despite the initial
#             impressions what we are being asked for pairs of *indices*, the
#             second ordered after the first, that satisfy the condition
#             that the sum of the elements indexed is evenly dividible by
#             the value *k*.
# 
#             we will need to iterate across each index for the first
#             element and then all following indices for the second,
#             repeating until we arrive at the second-to-last and last
#             indices. A modulo function will then test for divisibility.
# 
#         
#         
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub count_index_pairs( $arr, $div, $count = 0) {
    for my $i ( 0..$arr->$#* - 1) {
        for my $j ( $i+1..$arr->$#* ) {
            $count++ if ($arr->[$i] + $arr->[$j]) % $div == 0;
        }
    }
    return $count;
}



## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use Test::More;

is count_index_pairs( [4, 5, 1, 6], 2 ), 2, 'ex-1';
is count_index_pairs( [1, 2, 3, 4], 2 ), 2, 'ex-2';
is count_index_pairs( [1, 3, 4, 5], 3 ), 2, 'ex-3';
is count_index_pairs( [5, 1, 2, 3], 4 ), 2, 'ex-4';
is count_index_pairs( [7, 2, 4, 5], 4 ), 1, 'ex-5';

done_testing();
