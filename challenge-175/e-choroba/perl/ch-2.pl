#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Prime::Util qw{ euler_phi };

sub is_perfect_totient ($x) {
    my $sum = 0;
    my $phi = $x;
    $sum += $phi = euler_phi($phi) while $phi != 1;
    return $sum == $x
}

sub perfect_totient_numbers ($size) {
    my @numbers;
    my $candidate = 1;
    while (@numbers < $size) {
        push @numbers, $candidate if is_perfect_totient($candidate);
        ++$candidate;
    }
    return \@numbers
}

use Test::More tests => 1;

is_deeply perfect_totient_numbers(20),
          [3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
           2187, 2199, 3063, 4359, 4375, 5571];
