#!/usr/bin/perl
use 5.038;
use warnings;

sub makeGrid(@args) {
    my @grid;

    for my $row (@args) {
        push @grid, [split //, $row];
    }

    push @grid,    [('O') x scalar @{$grid[0]}];
    unshift @grid, [('O') x scalar @{$grid[0]}];

    for my $row (@grid) {
        unshift @$row, 'O';
        push @$row, 'O';
    }

    return @grid;
}

sub findLonely(@grid) {
    my $lonely = 0;

    for my $i (1 .. scalar @grid - 2) {
        for my $j (1 .. scalar @{$grid[$i]} - 2) {

            if ($grid[$i][$j] eq 'X') {
                my $neighbors = 0;
                for my $ii (-1 .. 1) {
                    for my $jj (-1 .. 1) {
                        if ($grid[$i + $ii]->[$j + $jj] ne 'X') {
                            $neighbors++;
                        }
                    }
                }

                if ($neighbors == 8) {
                    $lonely++;
                }
            }
        }
    }

    return $lonely;
}

say findLonely(makeGrid(@ARGV));
    