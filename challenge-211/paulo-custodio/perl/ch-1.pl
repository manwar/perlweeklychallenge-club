#!/usr/bin/env perl

# Perl Weekly Challenge 211 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-211/

use Modern::Perl;

sub parse_input {
    my @a;
    while (<>) {
        /\s*\[([\s\d,]+)\]\s*$/ or die "cannot parse: $_";
        my @row = map {s/\s+//gr} split(/\s*,\s*/, $1);
        push @a, \@row;
    }
    return @a;
}

sub is_toeplitz {
    my(@a) = @_;
    my $rows = scalar(@a);
    my $cols = scalar(@{$a[0]});

    # start from top row
    for my $c (0..$cols-2) {
        my $n = $a[0][$c];
        for my $d (0..$rows-1) {
            if ($d < $rows && $c+$d < $cols) {
                if ($a[$d][$c+$d] != $n) {
                    return 0;
                }
            }
        }
    }

    # start from left column
    for my $r (0..$rows-2) {
        my $n = $a[$r][0];
        for my $d (0..$cols-1) {
            if ($r+$d < $rows && $d < $cols) {
                if ($a[$r+$d][$d] != $n) {
                    return 0;
                }
            }
        }
    }

    return 1;
}

say is_toeplitz(parse_input());
