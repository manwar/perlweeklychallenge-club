#!/usr/bin/perl6

multi sub MAIN(
    Int $height,            #= the number of rows in the triangle
    ) {

    my &ptRow = -> $row, $col {
        $col == 1 || $col == $row
        ?? 1
        !! ptRow($row - 1, $col - 1) + ptRow($row - 1, $col)
    };

    for 1 .. $height -> $row {
        print ($row X (1 .. $row)).flat.map(&ptRow).join(), ' ';
    }
    print "\n";
}
