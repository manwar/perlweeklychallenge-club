#!/usr/bin/perl6
my @matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
];

my $bottom_edge = @matrix.elems - 1;
my $right_edge = @matrix[0].elems - 1;  # assuming matrix is square
my $row = 0;
my $col = 0;
my $total = @matrix[0][0];
my @path;
@path.push(@matrix[0][0]);

while $row != $bottom_edge || $col != $right_edge {

    my $down = ∞;
    if ($row + 1 <= $bottom_edge) {
        $down = $total + @matrix[$row + 1][$col];
    }

    my $right = ∞;
    if ($col + 1 <= $right_edge) {
        $right = $total + @matrix[$row][$col + 1];
    }

    if ($down < $right) {
        $row++;
        $total = $down;
    } else {
        $col++;
        $total = $right;
    }
    @path.push(@matrix[$row][$col]);
}

@path.join(' -> ').say;
