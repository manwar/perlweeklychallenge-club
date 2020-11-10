#!/usr/bin/env perl
use v5.32;
use List::Util qw(sum min);

sub find_squares {
    my $matrix = shift;

    say "\n# Matrix";
    for my $row (@$matrix) {
        say join " ", @$row;
    }

    say "#=> squares -> " . squares($matrix);
}

sub squares {
    my ($matrix, $s) = @_;
    my $h = @$matrix;
    my $w = @{$matrix->[0]};

    my $c = 0;
    for my $s (2..min($w,$h)) {
        for my $i (0..$h-$s) {
            for my $j (0..$w-$s) {
                if (1 == $matrix->[$i][$j] == $matrix->[$i+$s-1][$j] == $matrix->[$i][$j+$s-1] == $matrix->[$i+$s-1][$j+$s-1]) {
                    $c += 1;
                }
            }
        }
    }
    return $c;
}

## main;

#=> 1
find_squares [[ 0, 1, 0, 1 ],
              [ 0, 0, 1, 0 ],
              [ 1, 1, 0, 1 ],
              [ 1, 0, 0, 1 ]];

#=> 4
find_squares [[ 1, 1, 0, 1 ],
              [ 1, 1, 0, 0 ],
              [ 0, 1, 1, 1 ],
              [ 1, 0, 1, 1 ]];

#=> 0
find_squares [[ 0, 1, 0, 1 ],
              [ 1, 0, 1, 0 ],
              [ 0, 1, 0, 0 ],
              [ 1, 0, 0, 1 ]];

#=> 20
find_squares [[ 1, 1, 1, 1, 1 ],
              [ 1, 1, 1, 1, 1 ],
              [ 1, 1, 1, 1, 1 ],
              [ 1, 1, 1, 1, 1 ]];

#=> 20
find_squares [[ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ],
              [ 1, 1, 1, 1 ]];

#=> 1
find_squares [[ 1, 0, 0, 1 ],
              [ 0, 0, 0, 0 ],
              [ 0, 0, 0, 0 ],
              [ 1, 0, 0, 1 ],
              [ 0, 0, 0, 0 ]];
