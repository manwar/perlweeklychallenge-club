#!perl.exe

use strict;
use warnings;
use ntheory qw/ primes divisors is_prime /;
use Test::More;

=head1 NAME

Semiprime.pl  - Challenge #144

=head1 DESCRIPTION

In mathematics, a semiprime is a natural number that is the product
of exactly two prime numbers. The two primes in the product may
equal each other, so the semiprimes include the squares of prime numbers.

=head1 AUTHOR

Robert DiCicco

=head1 DATE

22-DEC-2021

=cut

my @results = ();
my $res;

my $expected = "4 6 9 10 14 15 21 22 25 26 33 34 35 38 39 46 49 51 55 57 58 62 65 69 74 77 82 85 86 87 91 93 94 95";

foreach my $pref ( 1 .. 100 ){
    my @divs = divisors($pref);
    # get rid of last divisor
    pop(@divs);

    # if there are only two divisors, save them
    if(scalar(@divs == 2)){
        push(@results, $pref);
    }

    # if there are three divisors, save last two if they are both prime
    if(scalar(@divs == 3)){
        if(is_prime($divs[1]) && is_prime($divs[2])){
            push(@results, $pref);
        }
    }
}

foreach(@results){
    $res .= "$_ ";
}

chop($res);

print("Results: $res\n");
print("Expected: $expected\n");

ok($res eq $expected, "semiprimes");

done_testing;
