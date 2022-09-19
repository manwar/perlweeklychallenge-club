#!/usr/bin/perl

=head1

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #2: Perfect Totient Numbers

    Write a script to generate first 20 Perfect Totient Numbers.

=cut

use v5.36;
use Test2::V0;

is [
     3, 9, 15, 27, 39, 81, 111, 183, 243,
     255, 327, 363, 471, 729, 2187, 2199,
     3063, 4359, 4375, 5571
   ], first_perfect_totient(20);

done_testing;

#
#
# METHODS

sub is_coprime($a, $b) {
    if ($a > $b) {
        ($a, $b) = ($b, $a);
    }
    while ($a) {
        ($a, $b) = ($b % $a, $a);
    }
    return $b == 1;
}

#
# Simply coded as shown in the example in the wiki page:
# https://en.wikipedia.org/wiki/Perfect_totient_number

sub is_perfect_totient($n) {
    my $i = $n;
    my $s = 0;
    while ($i >= 1) {
        my @coprimes = ();
        foreach (1 .. $i-1) {
            push @coprimes, $_ if is_coprime $_, $i;
        }
        $i = @coprimes;
        $s = $s + $i;
    }

    return $n == $s;
}

sub first_perfect_totient($n) {
    my @pt = ();
    my $i  = 1;
    while (@pt < $n) {
        push @pt, $i if is_perfect_totient $i;
        $i++;
    }

    return \@pt;
}
