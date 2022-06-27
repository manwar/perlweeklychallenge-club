#!/usr/bin/raku

sub printMatrix(@matrix) {
    for @matrix -> @row {
        for @row -> $col {
            $col.fmt('%2d ').print;
        }
        print "\n";
    }
}

sub MAIN() {
    my @A = ((1, 2),(3, 4));
    my @B = ((5, 6),(7, 8));

    printMatrix((@A X @B).map({ [X*] $_ }));
}