#!/usr/bin/perl

# Challenge 167
#
# Task 2: Gamma Function
# Submitted by: Mohammad S Anwar
#
# Implement subroutine gamma() using the Lanczos approximation method.
#
# [2022-05-31]
#
# Ryan Thompson wrote an interesting blog explaining the subject in details.
# Highly recommended if you are looking for more information. BLOG.
#
# Example
#
# print gamma(3); # 1.99
# print gamma(5); # 24
# print gamma(7); # 719.99

use Modern::Perl;
use Math::Complex qw( :pi Re Im );
use List::Util 'sum';

# https://en.wikipedia.org/wiki/Lanczos_approximation

use constant g => 7;
my @p = (
    0.99999999999980993,
    676.5203681218851,
    -1259.1392167224028,
    771.32342877765313,
    -176.61502916214059,
    12.507343278686905,
    -0.13857109526572012,
    9.9843695780195716e-6,
    1.5056327351493116e-7
);

use constant EPSILON => 1e-07;

sub drop_imag {
    my($z)=@_;
    if (abs(Im($z))<=EPSILON) {
        $z=Re($z);
    }
    return $z;
}

sub gamma {
    my($z)=@_;
    my $y;
    if (Re($z) < 0.5) {
        $y = pi / (sin(pi * $z) * gamma(1 - $z));  # Reflection formula
    }
    else {
        $z -= 1;
        my $x = $p[0];
        for my $i (1..$#p) {
            $x += $p[$i] / ($z + $i);
        }
        my $t = $z + g + 0.5;
        $y = sqrt(2 * pi) * $t ** ($z + 0.5) * exp(-$t) * $x;
    }
    return drop_imag($y);
}

say gamma(Math::Complex->new(shift));
