use strict;
use warnings;


#https://www.lavivienpost.com/depth-first-search-and-matrix/


sub largest_contiguous_block {
    my ($matrix) = @_;
    my $rows = @$matrix;
    my $cols = @{$matrix->[0]};
    my @visited = map { [(0) x $cols] } 1..$rows;

    my $max_size = 0;

    for my $r (0 .. $rows - 1) {
        for my $c (0 .. $cols - 1) {
            my $symbol = $matrix->[$r][$c];
            my $size = dfs($matrix, \@visited, $r, $c, $symbol);
            $max_size = $size if $size > $max_size;
        }
    }

    return $max_size;
}

sub dfs {
    my ($matrix, $visited, $row, $col, $symbol) = @_;

    return 0 if $row < 0 || $row >= @$matrix || $col < 0 || $col >= @{$matrix->[0]}
                || $visited->[$row][$col] || $matrix->[$row][$col] ne $symbol;

    $visited->[$row][$col] = 1;
    my $count = 1;

    $count += dfs($matrix, $visited, $row + 1, $col, $symbol);
    $count += dfs($matrix, $visited, $row - 1, $col, $symbol);
    $count += dfs($matrix, $visited, $row, $col + 1, $symbol);
    $count += dfs($matrix, $visited, $row, $col - 1, $symbol);

    return $count;
}

1;