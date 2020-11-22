#!/usr/bin/perl6

sub process($file) {
    return $file.IO.lines.map({
        [ $_.subst(q{_}, 0, :g).comb.grep({ / \d /; }) ];
    });
}

sub inBox(@puzzle, $row, $col, $num) {
    my @box;

    for $row .. $row + 2 -> $i {
        @box.push(| @puzzle[$i][$col .. $col + 2]);
    }

    return $num == @box.any;
}

sub inCol(@columns, $col, $num) {
    return $num == @columns[$col].any;
}

sub inRow(@puzzle, $row, $num) {
    return $num == @puzzle[$row].any;
}

sub isValid(@puzzle, $row, $col, $num) {
    my @columns = [Z] @puzzle;

    return
        !inRow(@puzzle, $row, $num) &&
        !inCol(@columns, $col, $num) &&
        !inBox(@puzzle, $row - $row % 3, $col - $col % 3, $num);
}

sub solve(@puzzle is copy) {

    for 0 ..^ @puzzle.elems -> $row {
        for 0 ..^ @puzzle[$row].elems -> $col {

            if @puzzle[$row][$col] == 0 {

                for (1 .. 9) -> $num {
                    if isValid(@puzzle, $row, $col, $num) {
                        @puzzle[$row][$col] = $num;

                        if solve(@puzzle) {
                            return True;
                        }
                        @puzzle[$row][$col] = 0;
                    }
                }

                return False;
            }
        }
    }

    return True;
}

sub MAIN (
    $sudoku,  #= file containing a sudoku puzzle
) {
    my @puzzle = process($sudoku);

    if solve(@puzzle) {
        for @puzzle -> @row {
            say q{[ }, @row.join(q{ }), q{ ]};
        }
    } else {
        say 'Unsolvable.';
    }
}