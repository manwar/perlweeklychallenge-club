# This program has been created by ChatGPT
#
# Test run:
# $ raku ch-2.raku
# [1 2 3 4]
# [[1 2] [3 4] [5 6]]
# [[1] [2]]
#
# Notice that if you change $r and $c to 3 and 2 in the last example,
# the program prints 0 as expected.

sub reshape-matrix (@matrix, $r, $c) {
    my $total_elements = 0;
    for @matrix -> @row {
        $total_elements += @row.elems;
    }
    if $total_elements != $r * $c {
        return 0;
    }

    my @result = [];
    my $element_index = 0;
    for (0 .. $r - 1) -> $i {
        my @new_row = [];
        for (0 .. $c - 1) -> $j {
            @new_row.push(@matrix[$element_index div @matrix[0].elems][$element_index % @matrix[0].elems]);
            $element_index++;
        }
        @result.push(@new_row);
    }

    if @result.elems == 1 {
        return @result[0];
    }
    else {
        return @result;
    }
}

my @matrix = [ [ 1, 2 ], [ 3, 4 ] ];
my $r = 1;
my $c = 4;
my $result = reshape-matrix(@matrix, $r, $c);
say $result;

@matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ] ];
$r = 3;
$c = 2;
$result = reshape-matrix(@matrix, $r, $c);
say $result;

@matrix = [ [ 1 ], [ 2 ] ];
$r = 2;
$c = 1;
$result = reshape-matrix(@matrix, $r, $c);
say $result;
