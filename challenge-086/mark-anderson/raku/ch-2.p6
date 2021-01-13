#
# using the algorithm from https://www.geeksforgeeks.org/sudoku-backtracking-7/
#

my $grid = " [_ _ _ 2 6 _ 7 _ 1] 
             [6 8 _ _ 7 _ _ 9 _] 
             [1 9 _ _ _ 4 5 _ _] 
             [8 2 _ 1 _ _ _ 4 _] 
             [_ _ 4 6 _ 2 9 _ _] 
             [_ 5 _ _ _ 3 _ 2 8] 
             [_ _ 9 3 _ _ _ 7 4] 
             [_ 4 _ _ 5 _ _ 3 6] 
             [7 _ 3 _ 1 8 _ _ _] ";

my @grid = $grid.trans("_" => "0").comb(/\d/).map(+*).rotor(9).map(*.Array);

if solve(@grid, 0, 0) { 
    .say for @grid 
}

sub solve(@grid, $row is copy, $col is copy) {
    return True if $row == 8 and $col == 9;

    if $col == 9 {
        $row++;
        $col = 0;
    }

    return solve(@grid, $row, $col+1) if @grid[$row][$col];  

    for 1..9 -> $num {
        if is-safe(@grid, $row, $col, $num) {
            @grid[$row][$col] = $num;
            return True if solve(@grid, $row, $col+1); 
        }

        @grid[$row][$col] = 0;
    }

    return False;
}
 
sub is-safe(@grid, $row, $col, $num) {
    return False if $num (elem) @grid[$row];

    return False if $num (elem) @grid.map(*[$col]);

    my $r = $row - $row mod 3;
    my $c = $col - $col mod 3;

    return False if $num (elem) @grid[$r..$r+2].map(*[$c..$c+2]).flat;

    return True;
}
