#!/usr/bin/env raku

sub good-string (+str) {
    str.subst: / (<:Lu>) <~~>* <{lc $0}> | (<:Ll>) <~~>* <{uc $0}> /, :g
}

multi MAIN (Bool :test($)!) {
    use Test;
    is good-string('WeEeekly'), 'Weekly';
    is good-string('abBAdD'), '';
    is good-string('abc'), 'abc';
    is good-string('xAayeBCcdDbEz'), 'xyz';
    done-testing;
}

multi MAIN ($str) {
    say good-string $str;
}
