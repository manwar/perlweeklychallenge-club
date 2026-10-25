#!/usr/bin/raku

sub MAIN(
    *@N
) {
    @N.classify({ $_}, into => my %count );

    %count.keys.grep({ %count{$_}.elems % 2 == 1 }).first.say;
}