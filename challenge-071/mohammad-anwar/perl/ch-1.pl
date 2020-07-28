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

my $S = $ARGV[0] || 10;
my $array = get_random_array($S);
my $peak_elements = get_peak_elements($array);

print sprintf("Array: [%s]\n", join(", ", @$array));
print sprintf(" Peak: [%s]\n", join(", ", @$peak_elements));

#
#
# METHODS

sub get_peak_elements {
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
        my $e = $max - int(rand($min + $max));
        next if (exists $elements{$e});
        $elements{$e} = 1;
        $size--;
    }

    return [ keys %elements ];
}
