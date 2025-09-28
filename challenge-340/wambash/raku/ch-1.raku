#!/usr/bin/env raku

sub duplicate-removals ($str) {
    $str.subst: / (.) <~~>* $0 /,:d,:g
}

multi MAIN (Bool :test($)!) {
    use Test;
    is duplicate-removals('abbaca'), 'ca';
    is duplicate-removals('azxxzy'), 'ay';
    is duplicate-removals('aaaaaaaa'), '';
    is duplicate-removals('aabccba'), 'a';
    is duplicate-removals('abcddcba'), '';
    done-testing;
}

multi MAIN ($str) {
    say duplicate-removals $str;
}
