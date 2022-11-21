#!/usr/bin/raku

sub MAIN(
    *@list
) {
    my @sorted = @list.sort;
   
    say @sorted[*-2] * 2 <= @sorted[*-1] ?? 1 !! -1;
}