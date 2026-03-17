#!/usr/bin/env perl

# Perl Weekly Challenge 270 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/

use Modern::Perl;

my @matrix = split /,/, "@ARGV";
@matrix = map {[split ' ', $_]} @matrix;

say count_special_pos(@matrix);

sub count_special_pos {
    my(@matrix) = @_;
    my $special = 0;
    for my $i (0 .. $#matrix) {
        for my $j (0 .. $#{$matrix[0]}) {
            $special++ if is_special_pos($i, $j, @matrix);
        }
    }
    return $special;
}

sub is_special_pos {
    my($i, $j, @matrix) = @_;
    return 0 if $matrix[$i][$j] != 1;
    for my $ii (0 .. $#matrix) {
        if ($ii != $i) {
            return 0 if $matrix[$ii][$j] != 0;
        }
    }
    for my $jj (0 .. $#{$matrix[0]}) {
        if ($jj != $j) {
            return 0 if $matrix[$i][$jj] != 0;
        }
    }
    return 1;
}
