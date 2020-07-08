#!/usr/bin/perl

#
# Perl Weekly Challenge - 068
#
# Task #1: Zero Matrix
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/
#

use strict;
use warnings;

my $R = $ARGV[0];
my $C = $ARGV[1];

my $matrix;
if (defined $R && defined $C) {
    die "ERROR: Invalid rows [$R].\n" unless ($R =~ /^\d+$/ && $R >=2 );
    die "ERROR: Invalid cols [$C].\n" unless ($C =~ /^\d+$/ && $C >=2 );

    $matrix = get_matrix(--$R, --$C);
}
else {
    $matrix = [
        [1, 0, 1],
        [1, 1, 1],
        [1, 0, 1],
    ];
}

my $zero_matrix = make_zero_matrix($matrix);

display_matrix('Matrix:', $matrix);
display_matrix('Zero Matrix:', $zero_matrix);

#
#
# METHODS

sub make_zero_matrix {
    my ($matrix) = @_;

    my $rows = $#$matrix;
    my $cols = $#{$matrix->[0]};

    my $zero_matrix = [];
    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            if ($matrix->[$r][$c] == 0) {
                # make zero row
                $zero_matrix->[$r][$_] = 0 foreach (0..$cols);
                # make zero col
                $zero_matrix->[$_][$c] = 0 foreach (0..$rows);
            }
        }
    }

    # fill empty cells, if any.
    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            $zero_matrix->[$r][$c] = 1 unless
                defined $zero_matrix->[$r][$c];
        }
    }

    return $zero_matrix;
}

sub get_matrix {
    my ($rows, $cols) = @_;

    # prabability of picking 1 is higher than 0 (80:20).
    my $min   = 0;
    my $max   = 9;
    my $array = [ 1, 0, 1, 1, 1, 1, 1, 0, 1, 1 ];

    my $matrix  = [];
    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            $matrix->[$r][$c] = $array->[int($min + rand($max - $min))];
        }
    }

    return $matrix;
}

sub display_matrix {
    my ($label, $matrix) = @_;

    print "$label\n";
    foreach my $r (0..$#$matrix) {
        print sprintf("[ %s ]\n", join ', ', @{$matrix->[$r]});
    }
    print "\n";
}
