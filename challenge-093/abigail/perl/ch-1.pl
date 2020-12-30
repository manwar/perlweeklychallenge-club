#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util qw [max];

#
# For the challenge description, see ../README.md
#
# There are two things to consider for this challenge:
# efficiency and accuracy.
#
# Effiency
# --------
#
# We could take all pairs of points, draw the line through them, and
# check how many of the other points lie on that line, and find the
# line with the most points on them.
#
# But this leads to a cubic algorithm.
#
# Observation:
#     If we have three points p_i, p_j, p_k, and the slope of the line
#     through p_i and p_j is the same as the slope of the line between
#     p_i and p_k then p_i, p_j, and p_k are colinear. Ergo, all points
#     p_l, i <> l, for which the line through p_i and p_l has the same
#     slope are colinear (and p_i is colinear with them as well).
#     And the reverse holds as well.
# 
# So, for each point p_i, we look at each point p_j, (i < j), and
# we calculate the slope the line through the two points make. For
# each slope calculated, we count how often it was calculated; adding 1
# to this value gives us the number of colinear points for a line with
# that slope which passes through p_i. It's then a matter of finding
# the maximum over all slopes, and all points.
#
# This leads to a quadractic solution, as we consider each pair of 
# points once.
#
#
# Accurancy
# ---------
#
# The algorithm involves calculating and comparing slopes. But slopes
# are ratios between numbers, and ratios have the tendency to not be
# integers. Computers are bad at comparing non-integers, due to rounding.
#
# To combat that, we will assume the input numbers are decimal numbers;
# that is, we're accepting numbers like 1, -7, and 3.5789, but we're
# not accepting number like 2E7. If we have any numbers with a radix point
# (decimal numbers which aren't integers), we first add enough zeros
# so all numbers have the same number of digits after the radix point
# (for integers, we add a radix point, and a bunch of zeros). Then we
# we remove the radix point. In effect, we have multiplied all numbers by
# a power of 10 (the same power for all numbers), avoiding any arithmetic
# on non-integers (so we have avoided any rounding).
#
# Of course, the resulting integers may be too big to fit in 64-bit,
# but that's a trade off we are making.
#
# However, that doesn't mean the slopes we get are integers. All we
# have succeeded so far is that the slopes will be rational numbers:
# a ratio between two integers. But instead of the slope itself, we
# can just store the two numbers forming the ratio. However, a ratio
# doesn't not have a unique representation: 2/3 and 4/6 are the same
# ratio (aka slope), but have different representation.
#
# Therefore, if we calculate a slope as a ratio of two numbers, we
# divide the numbers by their GCD, so we have a unique representation.
#


#
# Calculate the GCD of two numbers.
#
sub stein;
sub stein ($u, $v) {
    return $u if $u == $v || !$v;
    return $v if             !$u;
    my $u_odd = $u % 2;
    my $v_odd = $v % 2;
    return stein ($u >> 1, $v >> 1) << 1 if !$u_odd && !$v_odd;
    return stein ($u >> 1, $v)           if !$u_odd &&  $v_odd;
    return stein ($u,      $v >> 1)      if  $u_odd && !$v_odd;
    return stein ($u - $v, $v)           if  $u     >   $v;
    return stein ($v - $u, $u);
}

while (<>) {
    my %lines;
    my @numbers = /-?\d+(?:\.\d+)?/ag;
    #
    # Scale the numbers so are dealing with integers.
    # Note that we must do this work on strings, as we want to avoid
    # arithmetic on non-integer numbers.
    #
    my $max = max map {/\.(\d+)/a ? length $1 : 0} @numbers;
    if ($max) {
        #
        # Add 0's so all numbers have the same number of digits
        # after the radix point (and add a radix point first if
        # there isn't one yet); then remove the radix point.
        #
        foreach (@numbers) {
            /\.(\d+)/a ? ($_ .= "0" x ($max - length $1)) 
                       : ($_ .= "." . ("0" x $max));
            s/\.//;
        }
    }
    my @points  = map {[@numbers [$_ - 1, $_]]} grep {$_ % 2} keys @numbers;
    my $max_colinear = 0;

    for (my $i = 0; $i < @points - 1; $i ++) {
        my ($x1, $y1) = @{$points [$i]};
        my %slopes;
        for (my $j = $i + 1; $j < @points; $j ++) {
            my ($x2, $y2) = @{$points [$j]};
            #
            # Special case for vertical lines
            #
            my $slope;
            if ($x1 == $x2) {
                $slope = "v";
            }
            else {
                my $y_diff = $y2 - $y1;
                my $x_diff = $x2 - $x1;
                my $gcd    = stein abs ($y_diff), abs ($x_diff);
                my $neg    = (($y_diff < 0) xor ($x_diff < 0));
                $slope     = join ";" => ($neg ? "-" : "+"),
                                         abs ($y_diff) / $gcd,
                                         abs ($x_diff) / $gcd;
            }
            $slopes {$slope} ++;
        }
        my $best_colinear = 1 + max values %slopes; # Max number of points
                                                    # colinear with each
                                                    # other, and $point [$i]
        $max_colinear = $best_colinear if $best_colinear > $max_colinear;
    }
    say $max_colinear;
}


__END__
