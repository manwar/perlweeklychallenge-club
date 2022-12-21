#!/usr/bin/raku

sub MAIN(
    *@list
) {
    say @list
    .grep({ $_ % 2 != 1; })
    .classify({ $_ })
    .sort({$^b.value.elems <=> $^a.value.elems || $^a.key <=> $^b.key})
    .first
    .key
    || -1;
}