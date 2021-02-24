#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-101/
# TASK #1 › Pack a Spiral

use 5.030;
use warnings;
use Math::Pari qw(:number);
use integer;

my @input = @ARGV;
# my @input = (1,2,3,4);
# my @input = (1..6);
# my @input = (1..12);

sub tight_matrix_dimensions {
    my ($elements) = @_;
    my $divisors = divisors($elements);
    my $m = $divisors->[@$divisors/2];
    my $n = $elements / $m;
    return (Math::Pari::pari2iv($m), Math::Pari::pari2iv($n));
}

my ($m, $n) = tight_matrix_dimensions(scalar @input);

my ($lx, $ly) = (0, 0);
my ($ux, $uy) = ($m-2, $n-1);

my ($i, $j) = ($m-1, 0);
my ($dx, $dy) = (0, 1);

my @matrix;

foreach my $element (@input) {
    $matrix[$i][$j] = $element;
    if ($dx != 0) {
        $i += $dx;
        if ($i < $lx) {
            $i += 1;
            $j -= 1;
            ($dx, $dy) = (0, -1);
            $lx += 1;
        } elsif ($i > $ux) {
            $i -= 1;
            $j += 1;
            ($dx, $dy) = (0, 1);
            $ux -= 1;
        }
    } elsif ($dy != 0) {
        $j += $dy;
        if ($j < $ly) {
            $i += 1;
            $j += 1;
            ($dx, $dy) = (1, 0);
            $ly += 1;
        } elsif ($j > $uy) {
            $i -= 1;
            $j -= 1;
            ($dx, $dy) = (-1, 0);
            $uy -= 1;
        }
    }
}

foreach my $row (@matrix) {
    say join(' ', @$row);
}
