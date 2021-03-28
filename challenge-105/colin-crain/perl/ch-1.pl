#! /opt/local/bin/perl
#
#       i-told-you-for-the-nth-time.pl

#         TASK #1 › Nth root
#         Submitted by: Mohammad S Anwar
#         You are given positive numbers $N and $k.
# 
#         Write a script to find out the $Nth root of $k. For more information,
#         please take a look at the wiki page.
# 
#         Example
#         Input: $N = 5, $k = 248832
#         Output: 12
# 
#         Input: $N = 5, $k = 34
#         Output: 2.02
#
#       method:
# 
#           r^n = x     :x > 0
#             —>  n log r = log x
#             —>  log r = (log x) / n
#             —>  r = e ^ ( (log x) / n )
# 
#         sounds good. Lets make it.

#         problems: 
#             works, but the first example has no decimal places, the second many, but
#             the example truncates to two. We will use two as our model, and
#             then strip trailing 0s and the decimal point should we arrive at it during
#             the stripping process. All of this is merely cosmetic sugar to make our
#             results match the examples. The math is solid however you format it.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub nroot($n, $x) {
    my $res = sprintf "%2.2f",    exp( (log $x) / $n );
    $res =~ s/\.?0*$//;
    return $res;

}












use Test::More;

is nroot(5, 248832), 12, 'ex-1';
is nroot(5, 34), 2.02, 'ex-2';


is nroot(3, 125), 5, '5^3';
is nroot(x), 2.02, 'ex-2';
is nroot(4, 49), 2.02, 'ex-2';
is nroot(5, 34), 2.02, 'ex-2';
is nroot(5, 34), 2.02, 'ex-2';


done_testing();
