#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    @ints.classify( { $_}, :into(my %count));
    %count.keys.sort.grep({ %count{$_}.elems / @ints.elems > 0.33 }).first.say;
}