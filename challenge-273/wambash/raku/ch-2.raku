#!/usr/bin/env raku

sub B-after-A ($str) {
    $str.contains: /^ a* b+ $/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is B-after-A('aabb'),True;
    is B-after-A('abab'),False;
    is B-after-A('aaa'),False;
    is B-after-A('bbb'),True;
    done-testing;
}

multi MAIN ($str) {
    say B-after-A $str
}
