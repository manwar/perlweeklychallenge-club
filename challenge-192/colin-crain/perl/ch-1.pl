#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       flipping-your-wig.pl
#
#       Binary Flip
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer, $n.
# 
#         Write a script to find the binary flip.
# 
#         Example 1
#             Input: $n = 5
#             Output: 2
# 
#             First find the binary equivalent of the given integer, 101.
#             Then flip the binary digits 0 -> 1 and 1 -> 0 and we get 010.
#             So Binary 010 => Decimal 2.
# 
#         Example 2
#             Input: $n = 4
#             Output: 3
# 
#             Decimal 4 = Binary 100
#             Flip 0 -> 1 and 1 -> 0, we get 011.
#             Binary 011 = Decimal 3
# 
#         Example 3
#             Input: $n = 6
#             Output: 1
# 
#             Decimal 6 = Binary 110
#             Flip 0 -> 1 and 1 -> 0, we get 001.
#             Binary 001 = Decimal 1
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



sub binary_flip ( $n ) {
    return $n ^ calc_binary_ones( $n );
}

sub calc_binary_ones ( $n, $bin = 1 ) {
    $bin *= 2 while $bin <= $n;
    return $bin - 1;
}




use Test::More;

is binary_flip(5), 2, 'ex-1';
is binary_flip(4), 3, 'ex-2';
is binary_flip(6), 1, 'ex-3';

is binary_flip(1), 0, 'extra-1';
is binary_flip(2), 1, 'extra-2';
is binary_flip(3), 0, 'extra-3';
is binary_flip(7), 0, 'extra-7';
is binary_flip(8), 7, 'extra-8';
is binary_flip(9), 6, 'extra-9';


done_testing();
