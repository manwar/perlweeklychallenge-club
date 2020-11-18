#!/usr/bin/perl
use warnings;
use strict;

sub find_largest {
    my ($lines, $x, $y) = @_;
    my ($max, %how) = 0;
    for my $vector ([0, 1], [1, 0]) {
        my $m = $lines->[$y][$x][ $vector->[0] ];
        next if $m < 1;

        my $n = 1;
        while (my $m2 = $lines->[ $y + $n * $vector->[0] ]
                          [ $x + $n * $vector->[1] ]
                          [ $vector->[0] ]
        ) {
            last if $m2 < 1;

            $m = $m2 if $m2 < $m;

            if ($n > 0) {
                my $area = ($m + 1) * ($n + 1);
                if ($area > $max) {
                    $max = $area;
                    %how = ();
                }
                if ($area == $max) {
                    undef($vector->[0] ? $how{$m}{$n} : $how{$n}{$m});

                    # Surprisingly, this doesn't help the performance.
                    # last if ($m + 1) * ($lines->[$y][$x] + 1) <= $max;
                }
            }
            ++$n;
        }
    }
    my @coords = map {
        my $k = $_;
        map [ $k, $_ ], keys %{ $how{$k} }
    } sort { $a <=> $b } keys %how;
    return $max, @coords
}

sub calculate_lines {
    my ($matrix) = @_;
    my @lines;
    for my $y (0 .. $#$matrix) {
        for my $x (0 .. $#{ $matrix->[$y] }) {
            if ($matrix->[$y][$x]) {
                if ($y > 0 && $matrix->[$y - 1][$x]) {
                    $lines[$y][$x][0] = $lines[$y - 1][$x][0] - 1;
                } else {
                    my $j = $y;
                    ++$j while $j <= $#$matrix && $matrix->[$j][$x];
                    $lines[$y][$x][0] = $j - $y - 1;
                }
                if ($x > 0 && $matrix->[$y][$x - 1]) {
                    $lines[$y][$x][1] = $lines[$y][$x - 1][1] - 1;
                } else {
                    my $i = $x;
                    ++$i while $i <= $#{ $matrix->[$y] } && $matrix->[$y][$i];
                    $lines[$y][$x][1] = $i - $x - 1;
                }
            } else {
                $lines[$y][$x] = [0, 0];
            }
        }
    }
    return @lines
}

sub largest_rectangle_detail {
    my ($input) = @_;
    my @matrix;
    push @matrix, [ /[01]/g ] for split /\n/, $input;
    my @lines = calculate_lines(\@matrix);

    my $max = 0;
    my @where;
    for my $y (0 .. $#matrix) {
        for my $x (0 .. $#{ $matrix[$y] }) {
            next unless $lines[$y][$x][0] && $lines[$y][$x][1];

            my ($area, @how) = find_largest(\@lines, $x, $y);
            if ($area > $max) {
                @where = ();
                $max = $area;
            }
            push @where, [$x, $y, \@how] if $area == $max;
        }
    }
    return [$max, @where]
}

sub largest_rectangle {
    my ($input) = @_;
    my ($max, @where) = @{ largest_rectangle_detail($input) };
    return [0] unless $max;

    my @rectangles;
    for my $size (map @{ $_->[2] }, @where) {
        my ($x, $y) = @$size;
        my $r = "";
        for my $i (0 .. $y) {
            for my $j (0 .. $x) {
                $r .= ($j ? ' ' : "") . '1';
            }
            $r .= "\n"
        }
        push @rectangles, $r;
    }
    return \@rectangles
}

use Test::More;
use Test::Deep;

my @examples = (<< '__EXAMPLE__',
    [ 0 0 0 1 0 0 ]
    [ 1 1 1 0 0 0 ]
    [ 0 0 1 0 0 1 ]
    [ 1 1 1 1 1 0 ]
    [ 1 1 1 1 1 0 ]
__EXAMPLE__
<< '__EXAMPLE__',
    [ 1 0 1 0 1 0 ]
    [ 0 1 0 1 0 1 ]
    [ 1 0 1 0 1 0 ]
    [ 0 1 0 1 0 1 ]
__EXAMPLE__
<< '__EXAMPLE__',
    [ 0 0 0 1 1 1 ]
    [ 1 1 1 1 1 1 ]
    [ 0 0 1 0 0 1 ]
    [ 0 0 1 1 1 1 ]
    [ 0 0 1 1 1 1 ]
__EXAMPLE__
<< '__EXAMPLE__',
    [ 0 0 0 0 0 0 ]
    [ 0 1 1 1 0 0 ]
    [ 0 1 1 1 0 0 ]
    [ 0 1 1 0 0 0 ]
    [ 0 0 0 0 0 0 ]
    [ 0 0 0 0 0 0 ]
    [ 0 0 0 1 1 1 ]
    [ 0 0 0 1 1 1 ]
    [ 0 0 0 0 0 0 ]
__EXAMPLE__
<< '__EXAMPLE__',
    [ 1 1 1 1 1 1 ]
    [ 1 1 1 1 1 1 ]
    [ 1 1 1 1 0 0 ]
__EXAMPLE__
);

is_deeply largest_rectangle_detail($examples[0]),
    [10, [0, 3, [[4, 1]]]],
    'Example 1 - details';

is_deeply largest_rectangle_detail($examples[1]),
    [0],
    'Example 2 - details';

is_deeply largest_rectangle_detail($examples[2]),
    [8, [2, 3, [[3, 1]]]],
    'Example 3 - details';

cmp_deeply largest_rectangle_detail($examples[3]),
    [6, [1, 1, bag([1, 2], [2, 1])], [3, 6, [[2, 1]]]],
    'Three solutions - details';

cmp_deeply largest_rectangle_detail($examples[4]),
    [12, [0, 0, [[3, 2], [5, 1]]]],
    '2x6 versus 3x4 - details';

my %solution = ('5x2' => "1 1 1 1 1\n"   x 2,
                '4x2' => "1 1 1 1\n"     x 2,
                '2x3' => "1 1\n"         x 3,
                '3x2' => "1 1 1\n"       x 2,
                '4x3' => "1 1 1 1\n"     x 3,
                '6x2' => "1 1 1 1 1 1\n" x 2,
);

is_deeply largest_rectangle($examples[0]), [$solution{'5x2'}], 'Example 1';
is_deeply largest_rectangle($examples[1]), [0], 'Example 2';
is_deeply largest_rectangle($examples[2]), [$solution{'4x2'}], 'Example 3';
is_deeply largest_rectangle($examples[3]),
    [@solution{'2x3', '3x2', '3x2'}],
    'Three solutions';
is_deeply largest_rectangle($examples[4]),
    [@solution{'4x3', '6x2'}],
    '2x6 versus 3x4';

done_testing();
