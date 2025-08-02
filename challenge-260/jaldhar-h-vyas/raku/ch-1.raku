#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %count;
    @ints.map({ %count{$_}++ });
    say %count.values.elems == %count.values.unique.elems ?? 1 !! 0;
}