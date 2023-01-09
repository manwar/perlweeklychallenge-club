#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       prime-counting-hours.pl
#
#         Prime Count
#         Submitted by: Mohammad S Anwar
#         You are given an integer $n > 0.
# 
#         Write a script to print the count of primes less than $n.
# 
#         Example 1
#             Input: $n = 10
#             Output: 4 
# 
#             as in there are 4 primes less than 10 are 2, 3, 5, 7.
# 
#         Example 2
#             Input: $n = 15
#             Output: 6
# 
#         Example 3
#             Input: $n = 1
#             Output: 0
# 
#         Example 4
#             Input: $n = 25
#             Output: 9
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $n = shift @ARGV // 15;

say pcount_mpu($n);

sub pcount_mpu ($n) {
    use ntheory qw(primes);
    my $count = primes($n)->@*;
    return $count;
}

sub pcount_sieve($limit) {
##  sieve of Eratosthenes
    my @s = (1) x $limit;
    @s[0,1] = (0,0);    
    for my $f (2..sqrt($limit)) {    
        $s[$f * $_] = 0 for $f..$limit/$f;
    }
    return grep { $s[$_] } (0..$limit);
}














use Test::More;

is pcount_mpu(15),  6, 'ex-1-mpu';
is pcount_mpu(1),   0, 'ex-2-mpu';
is pcount_mpu(25),  9, 'ex-3-mpu';

is pcount_sieve(15),  6, 'ex-1-sieve';
is pcount_sieve(1),   0, 'ex-2-sieve';
is pcount_sieve(25),  9, 'ex-3-sieve';

done_testing();
