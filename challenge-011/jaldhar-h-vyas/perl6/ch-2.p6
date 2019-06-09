#!/usr/bin/perl6

multi sub MAIN(
    Int $n where $n > 1#= the size of the identity matrix
) { 

    for (0 .. $n - 1) -> $i {
        for (0 .. $n - 1) -> $j {
            print ($j == $i) ?? '1 ' !! '0 '; 
        }
        print "\n";
    }
}