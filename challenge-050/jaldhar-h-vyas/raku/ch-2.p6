#!/usr/bin/perl6

multi sub MAIN(*@ARGS) {
    my @L = @*ARGS.sort;
    my $size = @L.elems;

    loop (my $n = 0; $n < $size; $n++) {
        if (@L[$n] == $size - $n - 1) {
            say @L[$n];
        }
    }
}