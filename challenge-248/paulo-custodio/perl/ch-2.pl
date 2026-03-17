#!/usr/bin/env perl

# Perl Weekly Challenge 248 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/

use Modern::Perl;

my $matrix = parse_matrix("@ARGV");
my $sums = sum_submatrices($matrix);
print_matrix($sums);

sub parse_matrix {
    my($text) = @_;
    my @lines = split(/\]\s*,/, $text);
    my $matrix = [];
    for (@lines) {
        s/^\D+//;
        my @nums = split /\D+/, $_;
        push @$matrix, \@nums;
    }
    return $matrix;
}

sub sum_submatrices {
    my($matrix) = @_;
    my $sums = [];
    my $rows = scalar(@$matrix);
    my $cols = scalar(@{$matrix->[0]});
    for my $r (0 .. $rows-2) {
        for my $c (0 .. $cols-2) {
            $sums->[$r][$c] = 0;
            $sums->[$r][$c] += $matrix->[$r][$c];
            $sums->[$r][$c] += $matrix->[$r][$c+1];
            $sums->[$r][$c] += $matrix->[$r+1][$c];
            $sums->[$r][$c] += $matrix->[$r+1][$c+1];
        }
    }
    return $sums;
}

sub print_matrix {
    my($matrix) = @_;
    say "[", join(",\n ", map {"[ ".join(", ", @$_)." ]"} @$matrix), "]";
}
