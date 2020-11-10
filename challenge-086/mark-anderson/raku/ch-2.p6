#
# using the algorithm from https://www.geeksforgeeks.org/sudoku-backtracking-7/
#

my @sudoku := < _ _ _ 2 6 _ 7 _ 1 >,
              < 6 8 _ _ 7 _ _ 9 _ >,
              < 1 9 _ _ _ 4 5 _ _ >,
              < 8 2 _ 1 _ _ _ 4 _ >,
              < _ _ 4 6 _ 2 9 _ _ >,
              < _ 5 _ _ _ 3 _ 2 8 >,
              < _ _ 9 3 _ _ _ 7 4 >,
              < _ 4 _ _ 5 _ _ 3 6 >,
              < 7 _ 3 _ 1 8 _ _ _ >;

my @grid = @sudoku.map(*.Array);
$_.map({ $_ = +$_ if $_ ~~ /\d/ }) for @grid;

if solve(@grid, 0, 0) {
    .say for @grid;
}

sub solve(@grid, $row is copy, $col is copy) {
    if $row == 8 and $col == 9 {
        return True;
    }

    if $col == 9 {
        $row++;
        $col = 0;
    }

    if @grid[$row][$col] ~~ UInt { 
        return solve(@grid, $row, $col+1); 
    }

    for 1..9 -> $num {
        if is-safe(@grid, $row, $col, $num) {
            @grid[$row][$col] = $num;

            if solve(@grid, $row, $col+1) {
                return True;
            }
        }

        @grid[$row][$col] = "_";
    }

    return False;
}
 
sub is-safe(@grid, $row, $col, $num) {
    return False if $num (elem) @grid[$row];

    return False if $num (elem) @grid.map(*[$col]);

    my $r = $row - $row mod 3;
    my $c = $col - $col mod 3;

    return False if $num (elem) (@grid[$r  ][$c..$c+2],
                                 @grid[$r+1][$c..$c+2],
                                 @grid[$r+2][$c..$c+2]).flat;

    return True;
}
