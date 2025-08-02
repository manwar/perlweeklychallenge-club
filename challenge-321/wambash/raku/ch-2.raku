#!/usr/bin/env raku
sub backspace ($str) {
    $str.subst: / .<~~>?\# /,:d:g; #
}

sub backspace-compare (+str) {
    str
    andthen .map: &backspace
    andthen [eq] $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is backspace('ab##'), '';
    is backspace('a#b#'), '';
    is backspace-compare('ab#c','ad#c'), True;
    is backspace-compare('ab##','a#b#'), True;
    is backspace-compare('ab##','a#b#'), True;
    is backspace-compare('a#b','c'), False;
    done-testing;
}

multi MAIN (+str) {
    say backspace-compare str;
}
