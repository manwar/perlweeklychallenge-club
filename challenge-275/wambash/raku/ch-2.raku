#!/usr/bin/env raku

sub replace-digits ($str) {
    $str.subst(
        / $<letter>=\w <( $<shifts>=(\d)+ /,
        { chrs .<shifts>.map: -> \x { x + .<letter>.ord }   },
        :g
    )
}

multi MAIN (Bool :test($)!) {
    use Test;
    is replace-digits('a1c1e1'),   'abcdef';
    is replace-digits('a1b2c3d4'), 'abbdcfdh';
    is replace-digits('b2b'),      'bdb';
    is replace-digits('a16z'),     'abgz';
    done-testing;
}

multi MAIN ($str) {
    say replace-digits $str
}
