#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @missing = ((1.. @ints.elems) ∖ @ints».Int.unique).keys.sort({$^a <=> $^b});
    say q{(}, @missing.join(q{, }), q{)};
}