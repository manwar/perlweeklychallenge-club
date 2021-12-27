#!/usr/bin/env perl

# Challenge 128
#
# TASK #1 > Maximum Sub-Matrix
# Submitted by: Mohammad S Anwar
# You are given m x n binary matrix having 0 or 1.
#
# Write a script to find out maximum sub-matrix having only 0.
#
# Example 1:
# Input : [ 1 0 0 0 1 0 ]
#         [ 1 1 0 0 0 1 ]
#         [ 1 0 0 0 0 0 ]
#
# Output: [ 0 0 0 ]
#         [ 0 0 0 ]
# Example 2:
# Input : [ 0 0 1 1 ]
#         [ 0 0 0 1 ]
#         [ 0 0 1 0 ]
#
# Output: [ 0 0 ]
#         [ 0 0 ]
#         [ 0 0 ]

use Modern::Perl;

my @mx = parse_matrix();
my @submx = find_zeros(@mx);
print_matrix(@submx);

sub parse_matrix {
    my @mx;
    while (<>) {
        s/^\s*\[([01 ]+)\]\s*$/$1/ or die "malformed matrix\n";
        my @row = split(' ', $_);
        push @mx, \@row;
    }
    return @mx;
}

sub print_matrix {
    my(@mx) = @_;
    for (@mx) {
        my @row = @$_;
        say "[ ", join(" ", @row), " ]";
    }
}

sub find_zeros {
    my(@mx) = @_;
    my($max_rows, $max_cols) = (0, 0);

    for my $r1 (0 .. $#mx) {
        for my $c1 (0 .. $#{$mx[$r1]}) {
            next unless $mx[$r1][$c1]==0;
            for my $r2 ($r1 .. $#mx) {
                for my $c2 ($c1 .. $#{$mx[$r1]}) {
                    next unless $mx[$r2][$c2]==0;
                    my $rows = $r2-$r1+1;
                    my $cols = $c2-$c1+1;
                    if ($rows*$cols > $max_rows*$max_cols) {
                        if (all_zeros(\@mx, $r1, $c1, $r2, $c2)) {
                            ($max_rows, $max_cols) = ($rows, $cols);
                        }
                    }
                }
            }
        }
    }
    my @submx;
    for my $r (1 .. $max_rows) {
        push @submx, [(0) x $max_cols];
    }
    return @submx;
}

sub all_zeros {
    my($mx, $r1, $c1, $r2, $c2) = @_;
    for my $r ($r1 .. $r2) {
        for my $c ($c1 .. $c2) {
            return 0 if $mx->[$r][$c];
        }
    }
    return 1;
}
