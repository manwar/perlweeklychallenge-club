#!/usr/bin/env perl

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
     0.99999999999980993227684700473478,
   676.520368121885098567009190444019,
 -1259.13921672240287047156078755283,
   771.3234287776530788486528258894,
  -176.61502916214059906584551354,
    12.507343278686904814458936853,
    -0.13857109526572011689554707,
     9.984369578019570859563e-6,
     1.50563273514931155834e-7
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

say sprintf("%.0f", gamma(Math::Complex->new(shift)));
