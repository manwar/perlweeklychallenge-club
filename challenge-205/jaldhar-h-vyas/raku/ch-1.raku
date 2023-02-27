#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @array = @args.sort({ $^b <=> $^a }).unique;
    say @array.elems > 2 ?? @array[2] !! @array[0];
}