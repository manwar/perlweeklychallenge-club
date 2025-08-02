#!/usr/bin/env raku

sub clear-digits ($str) {
    $str.subst: / \D <~~>? \d/, :g
}

multi MAIN (Bool :test($)!) {
    use Test;
    is clear-digits('cab12'), 'c';
    is clear-digits('xy99'), '';
    is clear-digits('pa1erl'), 'perl';
    done-testing;
}

multi MAIN ($str) {
    say clear-digits $str;
}
