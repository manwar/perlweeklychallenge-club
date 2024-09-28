#!/usr/bin/raku

sub load($filename) {
    my @matrix;

    for $filename.IO.lines -> $line {
        @matrix.push($line.comb);
    }

    return @matrix;
}

sub inBounds($rows, $cols, $x, $y) {
    return $x >= 0 && $x < $rows && $y >= 0 && $y < $cols;
}

sub search(@matrix, $rows, $cols, @visited, $x, $y, $symbol) {
    if (!inBounds($rows, $cols, $x, $y) || @visited[$x][$y] || @matrix[$x][$y] ne $symbol) {
        return 0;
    }

    @visited[$x][$y] = True;
    my $size = 1;
    state @directions = ([0, 1], [1, 0], [0, -1], [-1, 0]);

    for @directions -> $dir {
        my ($dx, $dy) = @$dir;
        $size += search(@matrix, $rows, $cols, @visited, $x + $dx, $y + $dy, $symbol);
    }

    return $size;
}

sub largestContiguousBlock(@matrix) {
    my $rows = @matrix.elems;
    my $cols = @matrix[0].elems;
    my @visited =  (0 ..^ $rows).map({ [False xx $cols] });
    my $maxSize = 0;

    for 0 ..^ $rows -> $i {
        for 0 ..^ $cols -> $j {
            if !@visited[$i][$j] {
                my $currentSize = search(@matrix, $rows, $cols, @visited, $i, $j, @matrix[$i][$j]);

                if $currentSize > $maxSize {
                    $maxSize = $currentSize;
                }
            }
        }
    }

    return $maxSize;
}

sub MAIN(
    Str $filename  #= path to file containing matrix
) {
    say largestContiguousBlock(load($filename));
}