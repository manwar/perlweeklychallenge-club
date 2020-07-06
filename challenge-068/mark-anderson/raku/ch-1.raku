#!/usr/bin/env raku

my @matrix = [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 0, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1],
             [1, 1, 1, 1, 1, 1, 1, 1, 1];

my $rows = @matrix.elems;
my $cols = @matrix[0].elems;

my @zeroes = gather {
    for ^$rows -> $r {
        for ^$cols -> $c {
            take [$r, $c] if @matrix[$r][$c] == 0;
        }
    }
}

my %seen_row;
my %seen_col;

for @zeroes -> $p {
    unless %seen_row{$p[0]} {
        @matrix[$p[0]] = [0 xx $cols];
        %seen_row{$p[0]} = True;
    }

    unless %seen_col{$p[1]} {
        @matrix.map({$_[$p[1]] = 0;});
        %seen_col{$p[1]} = True;
    }
}

say @matrix.join("\n");
