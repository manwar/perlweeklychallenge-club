#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ sum };

sub gcd {
    my ($i, $j) = @_;
    while ($j != 0) {
        ($i, $j) = ($j, $i) if $j < $i;
        my $d = int($j / $i);
        $j -= $d * $i;
    }
    return $i
}

sub gcd_sum_naive {
    my ($n) = @_;
    my $s = 0;
    for my $i (2 .. $n) {
        for my $j (1 .. ($i - 1) / 2) {
            my $g = gcd($i, $j);
            $s += 2 * $g;  # Include also gcd($i, $i - $j) == gcd($i, $j)
        }
        $s += gcd($i, $i / 2) unless $i % 2;
    }
    return $s
}

{   my @totients;
    sub totients {
        my ($n) = @_;
        @totients = (0 .. $n);
        for my $p (2 .. $n) {
            if ($totients[$p] == $p) {
                $totients[$p] = $p - 1;
                for (my $i = 2 * $p; $i <= $n; $i += $p) {
                    $totients[$i] = ($totients[$i] / $p) * ($p - 1);
                }
            }
        }
    }

    sub gcd_sum {
        my ($n) = @_;
        totients($n);
        my @sums = (0) x $n;
        for my $i (1 .. $n) {
            for (my $j = 2; $i * $j <= $n; ++$j) {
                $sums[ $i * $j ] += $i * $totients[$j];
            }
        }
        for my $i (2 .. $n) {
            $sums[$i] += $sums[$i - 1];
        }
        return $sums[$n]
    }
}

use Test::More tests => 8;

is gcd_sum_naive(3), 3, 'Example 1 (naive)';
is gcd_sum_naive(4), 7, 'Example 2 (naive)';
is gcd_sum_naive(12), 105, 'Twelve (naive)';
is gcd_sum_naive(5000), 61_567_426, 'Large (naive)';

is gcd_sum(3), 3, 'Example 1';
is gcd_sum(4), 7, 'Example 2';
is gcd_sum(12), 105, 'Twelve';
is gcd_sum(5000), 61_567_426, 'Large';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    naive    => sub { gcd_sum_naive(1000) },
    totients => sub { gcd_sum(1000) },
});

__END__
           Rate    naive totients
naive    1.71/s       --    -100%
totients  570/s   33146%       --
