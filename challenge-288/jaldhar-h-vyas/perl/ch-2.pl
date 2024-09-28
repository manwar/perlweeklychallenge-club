#!/usr/bin/perl
use v5.38;

sub load($filename) {
    my @matrix;

    open my $file, '<', $filename or die "$!\n";
    while (my $line = <$file>) {
        push @matrix, [ split //, $line];
    }
    close $file;

    return \@matrix;
}

sub inBounds($rows, $cols, $x, $y) {
    return $x >= 0 && $x < $rows && $y >= 0 && $y < $cols;
}

sub search($matrix, $rows, $cols, $visited, $x, $y, $symbol) {
    if (!inBounds($rows, $cols, $x, $y) || $visited->[$x][$y] || $matrix->[$x][$y] ne $symbol) {
        return 0;
    }

    $visited->[$x][$y] = 1;
    my $size = 1;
    state @directions = ([0, 1], [1, 0], [0, -1], [-1, 0]);


    for my $dir (@directions) {
        my ($dx, $dy) = @$dir;
        $size += search($matrix, $rows, $cols, $visited, $x + $dx, $y + $dy, $symbol);
    }

    return $size;
}

sub largestContiguousBlock($matrix) {
    my $rows = scalar @{$matrix};
    my $cols = scalar @{$matrix->[0]};
    my @visited = map { [(0) x $cols] } (0 .. $rows - 1);
    my $maxSize = 0;

    for my $i (0 .. $rows - 1) {
        for my $j (0 .. $cols - 1) {
            if (!$visited[$i][$j]) {
                my $currentSize = search($matrix, $rows, $cols, \@visited, $i, $j, $matrix->[$i][$j]);
                if ($currentSize > $maxSize) {
                    $maxSize = $currentSize;
                }
            }
        }
    }

    return $maxSize;
}

my $filename = shift // die "Need filename\n";
say largestContiguousBlock(load($filename));
