#! /usr/bin/raku

sub solve-sudoku(@sudoku) {
    my @indexes := get-indexes(@sudoku);

    my $backtrack = 0;
    my $index = 0;
    while $index < @indexes.elems {
        die 'No solution possible' if $index < 0;

        my ($y, $x) = get-position @indexes[$index];
        my $guess = make-guess @sudoku, $y, $x, $backtrack;

        if $guess == 0 && !$backtrack {
            # not valid guess, We will try with next guess for same index
            $backtrack = 1;
        }
        elsif $guess == 0 && $backtrack {
            # not valid guess and no more guesses to test
            # We give up with this position (we decrement index)
            @sudoku[$y][$x] = 0;
            $index--;
        }
        else {
            # valid guess (for now), increase index
            @sudoku[$y][$x] = $guess;
            $backtrack = 0;
            $index++;
        }
    }

    @sudoku
}

# Returns the indexes to solve, sorted by number of ascending guesses
# so that we can speed up the process by processing first the boxes
# that have less possible guesses
sub get-indexes(@sudoku) {
    @sudoku>>.list.flat Z ^81
        ==> map({ $^it.tail, count-guesses @sudoku, $^it.tail })
        ==> grep *.tail > 0
        ==> sort({ $^a.tail cmp $^b.tail })
        ==> map *.head
        ==> my @indexes;

    @indexes.list
}

# Translate index to (y, x) matrix positions
sub get-position($index) {
    $index div 9, $index % 9
}

# Count the number of guesses for a box
# Returns 0 if the number was original
sub count-guesses(@sudoku, $index) {
    my ($y, $x) := get-position $index;

    @sudoku[$y][$x] > 0
        ?? 0
        !! elems get-guesses @sudoku, $y, $x, 0
}

# Get the guesses for a box
sub get-guesses(@sudoku, $y, $x, $last-guess) {
    my @cross-y := @sudoku>>[$x];
    my @cross-x := @sudoku[$y];
    my @square := get-square @sudoku, $y, $x;
    my @all-nums := (@cross-y, @cross-x, @square).flat.sort.unique.list;

    (1 .. 9)
        ==> grep({ 0 == elems @all-nums.grep: * == $^guess })
        ==> grep * > $last-guess
}

# For a (y,x) pair, it returns all the boxes of its inner square
sub get-square(@sudoku, $inner-y, $inner-x) {
    my $y := $inner-y - $inner-y % 3;
    my $x := $inner-x - $inner-x % 3;

    @sudoku[$y+0][$x+0], @sudoku[$y+0][$x+1], @sudoku[$y+0][$x+2],
    @sudoku[$y+1][$x+0], @sudoku[$y+1][$x+1], @sudoku[$y+1][$x+2],
    @sudoku[$y+2][$x+0], @sudoku[$y+2][$x+1], @sudoku[$y+2][$x+2],
}

# Makes some guess for a box.
# If we are backtracking, we set a minimum value for the guess
# (previous box value)
sub make-guess(@sudoku, $y, $x, $backtrack) {
    my $min-guess := $backtrack ?? @sudoku[$y][$x] !! 0;
    my @guesses := get-guesses(@sudoku, $y, $x, $min-guess).list;

    @guesses.elems == 0 ?? 0 !! @guesses.head
}

use Test;

is-deeply solve-sudoku([
    [ 0, 0, 0, 2, 6, 0, 7, 0, 1 ],
    [ 6, 8, 0, 0, 7, 0, 0, 9, 0 ],
    [ 1, 9, 0, 0, 0, 4, 5, 0, 0 ],
    [ 8, 2, 0, 1, 0, 0, 0, 4, 0 ],
    [ 0, 0, 4, 6, 0, 2, 9, 0, 0 ],
    [ 0, 5, 0, 0, 0, 3, 0, 2, 8 ],
    [ 0, 0, 9, 3, 0, 0, 0, 7, 4 ],
    [ 0, 4, 0, 0, 5, 0, 0, 3, 6 ],
    [ 7, 0, 3, 0, 1, 8, 0, 0, 0 ]
]),
[
    [ 4, 3, 5, 2, 6, 9, 7, 8, 1 ],
    [ 6, 8, 2, 5, 7, 1, 4, 9, 3 ],
    [ 1, 9, 7, 8, 3, 4, 5, 6, 2 ],
    [ 8, 2, 6, 1, 9, 5, 3, 4, 7 ],
    [ 3, 7, 4, 6, 8, 2, 9, 1, 5 ],
    [ 9, 5, 1, 7, 4, 3, 6, 2, 8 ],
    [ 5, 1, 9, 3, 2, 6, 8, 7, 4 ],
    [ 2, 4, 8, 9, 5, 7, 1, 3, 6 ],
    [ 7, 6, 3, 4, 1, 8, 2, 5, 9 ],
], 'Example sudoku';

is-deeply solve-sudoku([
    [ 9, 8, 7, 0, 0, 0, 0, 0, 0 ],
    [ 2, 4, 6, 0, 0, 3, 0, 8, 5 ],
    [ 3, 0, 1, 0, 2, 0, 0, 0, 0 ],
    [ 0, 0, 0, 5, 0, 7, 0, 0, 0 ],
    [ 0, 0, 4, 0, 0, 0, 1, 0, 0 ],
    [ 0, 9, 0, 0, 0, 0, 0, 0, 0 ],
    [ 5, 0, 0, 0, 0, 0, 0, 7, 3 ],
    [ 4, 0, 2, 0, 1, 0, 0, 0, 0 ],
    [ 8, 0, 0, 0, 4, 0, 0, 0, 9 ],
]),
[
    [ 9, 8, 7, 6, 5, 4, 3, 2, 1 ],
    [ 2, 4, 6, 1, 7, 3, 9, 8, 5 ],
    [ 3, 5, 1, 9, 2, 8, 7, 4, 6 ],
    [ 1, 2, 8, 5, 3, 7, 6, 9, 4 ],
    [ 6, 3, 4, 8, 9, 2, 1, 5, 7 ],
    [ 7, 9, 5, 4, 6, 1, 8, 3, 2 ],
    [ 5, 1, 9, 2, 8, 6, 4, 7, 3 ],
    [ 4, 7, 2, 3, 1, 9, 5, 6, 8 ],
    [ 8, 6, 3, 7, 4, 5, 2, 1, 9 ],
], 'Hard sudoku';

done-testing;
