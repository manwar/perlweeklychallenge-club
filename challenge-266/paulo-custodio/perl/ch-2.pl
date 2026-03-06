#!/usr/bin/env perl

use Modern::Perl;

my @matrix = parse_matrix("@ARGV");
say is_x(@matrix) ? 'true' : 'false';

sub parse_matrix {
    my($text) = @_;
    my @lines = split /,/, $text;
    my @matrix = map {[split ' ', $_]} @lines;
    return @matrix;
}

sub is_x {
    my(@matrix) = @_;

    return 0 if scalar(@matrix) != scalar(@{$matrix[0]});   # not square

    for my $i (0 .. $#matrix) {
        for my $j (0 .. $#matrix) {
            if ($i == $j || $#matrix - $i == $j) {
                return 0 if $matrix[$i][$j] == 0;
            }
            else {
                return 0 if $matrix[$i][$j] != 0;
            }
        }
    }

    return 1;
}
