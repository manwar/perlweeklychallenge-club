#!/usr/bin/perl

#
# Perl Weekly Challenge - 078
#
# Task #2: Left Rotation
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078
#

use strict;
use warnings;

my $A = $ARGV[0] || "10, 20, 30, 40, 50";
my $B = $ARGV[1] || "3, 4";

p(left_rotation(get_list($A), get_list($B)));

#
#
# METHODS

sub left_rotation {
    my ($source, $index) = @_;

    my $left_rotation = [];
    foreach my $i (@$index) {
        my $array = [];
        foreach my $j ($i .. $#$source) {
            push @$array, $source->[$j];
        }
        if ($i > 0) {
            foreach my $k (0 .. $i-1) {
                push @$array, $source->[$k];
            }
        }
        push @$left_rotation, $array;
    }

    return $left_rotation;
}

sub p {
    my ($data) = @_;

    foreach (@$data) {
        printf("%s\n", join ", ", @$_);
    }
}

sub get_list {
    my ($l) = @_;

    die "ERROR: Missing list.\n"      unless defined $l;
    die "ERROR: Invalid list [$l].\n" unless ($l =~ /^[\-?\d\,?\s?]+$/);

    $l =~ s/\s//g;
    return [ split /\,/, $l ];
}
