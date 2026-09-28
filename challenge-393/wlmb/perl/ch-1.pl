#!/usr/bin/env perl
# Perl weekly challenge 393
# Task 1:  Pythagoras Multiplied
#
# See https://wlmb.github.io/2026/09/28/PWC393/#task-1-pythagoras-multiplied
use v5.40;
use Math::Prime::Util qw(gcd);
use POSIX qw(fmin);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find how many Pythagorean triplets can be formed with
    positive numbers up to Ni
    FIN
for(@ARGV){
    say "$_ -> ", pythagorean($_);
}
sub pythagorean($n){ # count pythagorean triplets
    my $t=0;
    for my $x(2..sqrt $n){
	for my $y(1..fmin($x-1, $n-$x**2)){
	    next unless gcd($x**2-$y**2,2*$x*$y)==1; # check relative primes
	    $t += floor(($n)/($x**2+$y**2));         # count multiples
	}
    }
    return 2*$t;                                     # add permutations
}
