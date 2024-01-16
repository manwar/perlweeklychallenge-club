#!/usr/bin/env raku

use v6.d;

sub alphanumeric-string-value(@alphanumstr --> Int:D) {
    max(map({ $_ ~~ /<[a..zA..Z]>/ ?? chars($_) !! Int($_)}, @alphanumstr));
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is alphanumeric-string-value(("perl", "2", "000", "python", "r4ku")), 6,
        'works for ("perl", "2", "000", "python", "r4ku")';
    is alphanumeric-string-value(("001", "1", "000", "0001")), 1,
        'works for ("001", "1", "000", "0001")';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(*@s) {
    say alphanumeric-string-value(@s);
}
