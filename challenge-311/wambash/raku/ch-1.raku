#!/usr/bin/env raku

sub upper-lower ($str) {
    $str.subst(
        /$<uc>=<:Lu> | $<lc>=<:Ll> /,
        { .<uc> ?? .<uc>.lc !! .<lc>.uc },
        :g
    )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is upper-lower('pERl'),'PerL';
    is upper-lower('rakU'),'RAKu';
    is upper-lower('PyThOn'),'pYtHoN';
    done-testing;
}

multi MAIN ($str) {
    say upper-lower $str
}
