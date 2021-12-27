#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#     the-last-straw.pl
#
#     Divisor Last Digit
#         Submitted by: Mohammad S Anwar
#         You are given positive integers, $m and $n.
# 
#         Write a script to find total count of divisors of $m having last
#         digit $n.
# 
# 
#         Example 1:
# 
#             Input: $m = 24, $n = 2
#             Output: 2
# 
#             The divisors of 24 are 1, 2, 3, 4, 6, 8 and 12.
#             There are only 2 divisors having last digit 2 are 2 and 12.
# 
#         Example 2:
# 
#             Input: $m = 30, $n = 5
#             Output: 2
#     
#             The divisors of 30 are 1, 2, 3, 5, 6, 10 and 15.
#             There are only 2 divisors having last digit 5 are 5 and 15.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $num = shift // 30;
my $val = shift // 5;

my @div   = nd_brute( $num );
my $count = grep { /$val\Z/ } @div;

## output 
say "Input:  m = $num, n = $val";
say "Output: $count";


sub nd_brute ( $num, @div ) {
    $num % $_ or push @div, $_ for 2..$num/2 ;    
    return 1, @div, $num;
}













# use Test::More;
# 
# is 
# 
# done_testing();
