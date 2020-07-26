#!/usr/bin/perl6

multi sub MAIN(
    Int $M,     #= The number of rows in the matrix
    Int $N,     #= The number of columns in the matrix
    *@matrix    #= The elements of the matrix
) {
    my @input = (0 ..^ $M).map({ [@matrix.splice(0, $N)] });
    my @output = [1 xx $N] xx $M;

    for 0 ..^ $M -> $m {
        if @input[$m;*].any == 0 {
            @output[$m;*] = 0 xx $M;
        }
    }

    for 0 ..^ $N -> $n {
        if @input[*;$n].any == 0 {
            @output[*;$n] = 0 xx $N;
        }
    }

    for 0 ..^ $M -> $m {
        say @output[$m];
    }
}