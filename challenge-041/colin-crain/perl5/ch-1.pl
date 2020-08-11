#! /opt/local/bin/perl
#
#       attractors.pl
#
#       PWC 41
#       TASK #1
#           Write a script to display attractive number between 1 and 50. A
#           number is an attractive number if the number of its prime factors is
#           also prime number.
#
#           The number 20 is an attractive number, whose prime factors are 2, 2
#           and 5. The total prime factors is 3 which is also a prime number.
#
#       method: first sexy primes, now attractive numbers. So many numbers,
#           so many looks. I am a little concerned that all this objectifying
#           might give certain less-confident numbers quantity quality issues.
#           Let's not forget the truism that "all numbers are interesting"; whether
#           amicable, betrothed, deficiant or slightly defective they are all
#           Pythagoras' children and all deserve love. .
#
#           So anyways, we will pull out our prime decomposition engine from PWC23,
#           which we also saw in challenges 29 and 34.
#
#           Unable to leave well enough alone, we've tuned and tightened it,
#           replacing the origianal prime generating subfunction with a list of
#           all primes less or equal to the upper bound, which have been made a
#           user defined variable with a default of 50.
#
#           We need to know the prime decomposition, but only briefly enough to
#           sum it and compare this to our prime list. As we have the prime list
#           already present in the function we could do the comparison then and
#           there, return true or false, grep the list of calling it from 1 to
#           50 and call it a day. But merely presenting the numbers without
#           demonstrating their attractiveness seemed a bit off the mark, like
#           talking about a fashion show on the radio instead of going to a
#           fashion show to see the runway. So a table is produced of all the
#           numbers, their decompositions, and finally judgement on their
#           attractiveness. It appears the group of numbers between 1 and 50,
#           taken as a whole are a pretty good-looking bunch.
#

#
#
#

#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $max = shift @ARGV // 50;

my @primes = make_prime_list($max);
my %primehash = map { $_ => 1 } @primes;

for (2..$max) {
    my @decomp = decompose($_, \@primes);
    printf "%-4d--> %-20s  %s\n", $_, (join ', ', @decomp),
            (exists $primehash{(scalar @decomp)}) ? "$_ is attractive" : "" ;
}

## ## ## ## ## SUBS

sub make_prime_list {
## creates a list of all primes less than or equal to a given number
    my $max = shift;
    my @output = (2);
    CANDIDATE: for(  my $candidate = 3;  $candidate <= $max;  $candidate += 2  ) {
        my $sqrt_candidate = sqrt( $candidate );
        for(  my $test = 3; $test <= $sqrt_candidate; $test += 2  ) {
            next CANDIDATE if $candidate % $test == 0;
        }
        push @output, $candidate;
    }
    return @output;
}

sub decompose {
## given a number and a list of primes less than n/2,
## returns an array list of prime decomposition factors of the number
    my ($num, $primes) = @_;
    my @decomp;
    my @primelist = $primes->@*;
    my $prime = shift @primelist;

    while ( $prime <= $num ) {
        while ($num % $prime == 0) {
            $num = $num / $prime;
            push @decomp, $prime;
        }
        last if scalar @primelist == 0;
        $prime = shift @primelist;
    }
    return @decomp;
}
