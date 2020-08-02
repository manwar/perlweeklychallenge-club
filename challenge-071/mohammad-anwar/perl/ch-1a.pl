#!/usr/bin/perl

#
# Perl Weekly Challenge - 071
#
# Task #1: Peak Elements
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071
#

use strict;
use warnings;

use Test::More;
use Test::Deep;

my %test_cases = (
    'test case 1' => {
        in  => [19, 8, 22, 11, 50, 34, 39, 48, 12, 33],
        out => [19, 22, 50, 48, 33],
    },
    'test case 2' => {
        in  => [26, 39, 23, 16, 30, 4, 49, 42, 12, 14],
        out => [39, 30, 49, 14],
    },
    'test case 3' => {
        in  => [20, 24, 22, 48, 49, 23, 39, 10, 14, 43],
        out => [24, 49, 39, 43],
    },
);

foreach my $test (sort keys %test_cases) {
    is_deeply(
        find_peak_elements_in($test_cases{$test}->{in}),
        $test_cases{$test}->{out},
        $test
    );
}

done_testing;

#
#
# METHOD

sub find_peak_elements_in {
    my ($array) = @_;

    my @peak_elements = ();
    if ($#$array >= 2 ) {

        if ($array->[0] > $array->[1]) {
            push @peak_elements, $array->[0];
        }

        for my $i (1 .. $#$array-1) {
            push @peak_elements, $array->[$i]
                if (($array->[$i] > $array->[$i-1])
                    && ($array->[$i] > $array->[$i+1]));
        }

        if ($array->[-1] > $array->[-2]) {
            push @peak_elements, $array->[-1];
        }
    }

    return \@peak_elements;
}
