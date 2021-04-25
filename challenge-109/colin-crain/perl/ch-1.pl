#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       chowla.pl
#
#       TASK #1 › Chowla Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Chowla Numbers, named after, Sarvadaman D. S. Chowla, a London born Indian American mathematician. It is defined as:
# 
#         C(n) = sum of divisors of n except 1 and n
# 
#         Output:
#         0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

for (1..20, 479001600) {
     printf "C(%d)%*s= %d\n", $_,  3-length, ' ', sum_divisors($_);
}

sub sum_divisors ($n) {
    my $out = 0;
    for (2..sqrt $n) {
        unless ($n % $_) {
            $out += ($n/$_ == $_ ? $_ : $_ + $n/$_) ;
        }
    }
    return $out;
}

