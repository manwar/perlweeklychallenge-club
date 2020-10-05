#!/usr/bin/perl6

sub MAIN(
    *@N #= a list of integers
) {
    my @candies = 1 xx @N.elems;

    for 0 ..^ @N.elems -> $i {
        if @N[$i] > (@N[$i - 1] // Inf) {
            @candies[$i]++;
        }
        if @N[$i] > (@N[$i + 1] // Inf) {
            @candies[$i]++;
        }
    }
    say [+] @candies;
}