#!/usr/bin/perl6

sub MAIN(
    Str $file #= a file describing a matrix of 1's and 0's where every line
              #= is a row in the matrix.
) {
    my @matrix;
    for $file.IO.lines -> $line {
        @matrix.push($line.comb);
    }

    my $squares = 0;

    for 0 ..^ @matrix.elems -> $m {
        for 0 ..^ @matrix[$m].elems -> $n {
            if @matrix[$m][$n] == 1 {
                loop (my $side = 1; $n + $side < @matrix[$m].elems; $side++) {
                    if @matrix[$m][$n + $side] == 1
                        && $m + $side < @matrix.elems
                        && @matrix[$m + $side][$n] == 1
                        && @matrix[$m + $side][$n + $side] == 1 {
                        $squares++;
                    }
                } 
            }
        }
    }

    say $squares;
}