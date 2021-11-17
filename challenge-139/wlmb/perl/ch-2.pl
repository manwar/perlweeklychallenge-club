#!/usr/bin/env perl
# Perl weekly challenge 139
# Task 2: Long Primes
#
# See https://wlmb.github.io/2021/11/16/PWC139/#task-2-long-primes
use v5.12;
use warnings;
use bignum;
use Math::Prime::Util qw(next_prime);
use List::Util qw(first);
use Text::Wrap qw(wrap $columns $break);
$columns=62;
$break=qr/\s|_/;
my $max_count=shift @ARGV//5; # get number of long primes from command line
my $prime=2; #current prime (will skip '2')
my $count=0;
my @lines;
while($count<$max_count){
    $prime=next_prime($prime);
    my $length=$prime-1; # expected length of large cycle
    Math::BigFloat->accuracy(3.5*$length); # allow 3+ repetitions
    my @groups= grep {$_} split /(\d{$length})/, 1./$prime; # groups of digits
    pop @groups; # throw away last (guard) repetition (posibly inexact)
     ++$count, push @lines,
                    "long_prime[$count] is $prime",
		    "       as 1/$prime = " . shift(@groups) . join "_", @groups,"..."
        if (first # if cycle doesn't stop early
           {my $x=10**$_%$prime; $x==1||$x==0}
           (1..$prime-1))
	   == $prime-1
}
say wrap("", "                  _", $_) for @lines;
