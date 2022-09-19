#!/usr/bin/env perl
#
# ch-1a.pl - Alternative abundant number methods
#
# This file contains some of the code from my blog post, some benchmarks,
# and other useful tidbits not part of my main solution.
#
# Blog: https://ry.ca/2022/06/odd-abundant-numbers/
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use List::Util qw< sum >;
use Math::Prime::Util qw< divisor_sum >;
use Benchmark qw< cmpthese >;
use Test::More;

sub odd_abundant_iterator(&);
sub n_odd_abundant(&$);

is_deeply([ n_abundant_sqrt() ], [ n_abundant_naive() ]);
is_deeply([ n_abundant_sqrt() ], [ n_abundant_mpu() ]);

done_testing;

my $N = $ARGV[0] // 20; # First $N numbers

say scalar n_abundant_sieve(100000);

# Best algorithm. Uses a sieve-like method to reduce runtime
# down to n log n
sub n_abundant_sieve {
    my $lim = shift;
    my @r;

    my @div_sum; # Sum of divisors for each number
    for my $n (1..$lim) {
        $div_sum[$n*$_] += $n for 1..$lim/$n+1;
        push @r, $n if $n % 2 and 2*$n <= $div_sum[$n];
    }

    @r;
}

# If you just want to know if a particular number is abundant, use this
sub is_abundant {
    my $n = shift;
    my $sum = divisor_sum($n);

    2*$n < $sum;
}

cmpthese(-5, {
#   naive   => sub { n_abundant_naive($N) },
#   sqrt    => sub { n_abundant_sqrt($N) },
    mpu     => sub { n_abundant_mpu($N) },
    sieve   => sub { n_abundant_sieve(10000) },
});

# Check divisors up to sqrt($n)
sub n_abundant_sqrt {
    n_odd_abundant {
        my $n    = shift;
        my $sqrt = sqrt($n);

        my $sum  = sum map { $_,  $n / $_ } 
                      grep { $n % $_ == 0 } 1..$sqrt;

        $sum -= $sqrt if $sqrt == int $sqrt;
        
        2*$n < $sum;
    } $_[0];
}

# Use Math::Prime::Util's divisor_sum for quick divisors
sub n_abundant_mpu {
    n_odd_abundant {
        my $n = shift;
        my $sum = divisor_sum($n);

        2*$n < $sum;
    } $_[0];
}

# Brute force every divisor up to n/2
sub n_abundant_naive {
    n_odd_abundant {
        my $n = shift;
        $n < sum grep { $n % $_ == 0 } 1..$n/2;
    } $_[0];
}

# Returns the first $N odd abundant numbers using the method of choice
sub n_odd_abundant(&$) {
    my ($is_abundant, $N) = @_;

    my @r;
    for (my $n = 3; $N; $n += 2) {
        if ($is_abundant->($n)) {
            push @r, $n;
            $N--
        }
    }

    @r;
}

# Checks for abundant numbers using the method of choice up to the $N-th
# abundant number.
sub odd_abundant_iterator(&) {
    my $is_abundant = shift;
    my $n = 1;
    
    sub {
        do { $n += 2 } until $is_abundant->($n);

        $n;
    }
}
