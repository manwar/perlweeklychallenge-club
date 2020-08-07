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

my $N = $ARGV[0] || 10;
my $random_array  = get_random_array($N);
my $peak_elements = find_peak_elements_in($random_array);

print sprintf("Array: [%s]\n", join(", ", @$random_array));
print sprintf(" Peak: [%s]\n", join(", ", @$peak_elements));

#
#
# METHODS

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

sub get_random_array {
    my ($size) = @_;

    my $min = 1;
    my $max = 50;
    my %elements = ();
    while ($size >= 1) {
        my $e = $min + int(rand($max - $min)) + 1;
        next if (exists $elements{$e});
        $elements{$e} = 1;
        $size--;
    }

    return [ keys %elements ];
}
