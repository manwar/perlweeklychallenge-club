#!/usr/bin/env perl
# Perl weekly challenge 168
# Task 2: Home prime
#
# See https://wlmb.github.io/2022/06/06/PWC168/#task-2-home-prime
use v5.12;
use warnings;
use Math::Prime::Util qw(is_prime factor);
die "Usage: $0 n1 [n2... ]\n to obtain the home primes of n1..." unless @ARGV;
for(@ARGV){
    say("The argument ($_) should have been >=2"), next unless $_>=2;
    my $N=$_;
    $N=join "", factor($N) while(!is_prime($N));
    say "HP$_=$N"
}
