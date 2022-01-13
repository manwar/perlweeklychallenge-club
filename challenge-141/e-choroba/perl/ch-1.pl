#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use constant {
    DIVISOR_TALLY => 8,
    RESULT_TALLY  => 10,
};

sub number_divisors_full {
    my @results;
    my $i = 1;
    while (@results < RESULT_TALLY) {
        my @d = grep 0 == $i % $_, 1 .. $i;
        push @results, $i if @d == DIVISOR_TALLY;
    } continue {
        ++$i;
    }
    return @results
}

sub number_divisors_short {
    my @results;
    my $i = 1;
    while (@results < RESULT_TALLY) {
        my $divisor_tally = 0;
        my $s = sqrt $i;
        for my $d (1 .. $s) {
            $divisor_tally += ($d == $s) ? 1 : 2 if 0 == $i % $d;
        }
        push @results, $i if $divisor_tally == DIVISOR_TALLY;
    } continue {
        ++$i;
    }
    return @results
}

say join ', ', number_divisors_short();

use Test2::V0;
plan 1;
is [number_divisors_short], [number_divisors_full], 'same';

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    full  => \&number_divisors_full,
    short => \&number_divisors_short,
});
