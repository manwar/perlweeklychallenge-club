#!/usr/bin/env perl

use Modern::Perl;

my $matrix = parse_matrix("@ARGV");
say is_reduced_row_echelon($matrix);

sub parse_matrix {
    my($text) = @_;
    my @lines = split(/\]\s*,/, $text);
    my $matrix = [];
    for (@lines) {
        s/^[^-0-9]+//;
        my @nums = split /[^-0-9]+/, $_;
        push @$matrix, \@nums;
    }
    return $matrix;
}

sub is_reduced_row_echelon {
    my($matrix) = @_;
    my @matrix = @$matrix;

    # leading 1 is indented
    my $last_one_col = -1;
    my $found_zero_row;
    for (@matrix) {
        my @row = @$_;
        my $col = first_non_zero_col(@row);
        if ($found_zero_row) {
            if ($col >= 0) {
                return 0;
            }
        }
        else {
            if ($col < 0) {
                $found_zero_row = 1;
            }
            else {
                if ($row[$col] != 1) {
                    return 0;
                }
                elsif ($col <= $last_one_col) {
                    return 0;
                }
                else {
                    $last_one_col = $col;
                }
            }
        }
    }

    # column of leading one is all zeros
    for my $row (0 .. $#matrix) {
        my @row = @{$matrix[$row]};
        my $col = first_non_zero_col(@row);
        if ($col >= 0) {
            for my $zero_row (0 .. $row-1, $row+1 .. $#matrix) {
                if ($matrix[$zero_row][$col] != 0) {
                    return 0;
                }
            }
        }
    }

    return 1;
}

sub first_non_zero_col {
    my(@row) = @_;
    my $col = 0;
    while ($col < @row && $row[$col] == 0) {
        $col++;
    }
    if ($col == scalar(@row)) {
        return -1;
    }
    else {
        return $col;
    }
}

sub is_zero_row {
    my(@row) = @_;
    return first_non_zero_col(@row) == -1;
}
