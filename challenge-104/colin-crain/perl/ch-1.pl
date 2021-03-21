#! /opt/local/bin/perl
#
#       fusc-yuo-too.pl
#
#         TASK #1 › FUSC Sequence
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 50 members of FUSC Sequence. 
#         Please refer to OEIS for more information._
# 
#         The sequence defined as below:
# 
#         fusc(0) = 0
#         fusc(1) = 1
#         for n > 1:
#         when n is even: fusc(n) = fusc(n / 2),
#         when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use Memoize;

memoize qw(fusc);

sub fusc ($n) {
say $n;
    return undef if $n < 0;
    return 0 if $n == 0;
    return 1 if $n == 1;
    
    $n % 2 && return fusc(($n-1)/2) + fusc(($n+1)/2);
    
    return fusc($n/2);
}

my @out;
for ( 0..49 ) {
    push @out, fusc($_);
}

say join ', ', @out;









# use Test::More;
# 
# is 
# 
# done_testing();
