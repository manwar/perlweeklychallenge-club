#!/usr/bin/env raku

sub sort-language(@lang, @positions --> List) {
    my %pos-hash = Hash(@positions Z=> @lang);
    %pos-hash{ sort(@positions) }
}

#| Run test cases
multi sub MAIN() {
    use Test;
    plan 2;

    is sort-language(['perl', 'c', 'python'], [2, 1, 3]),
        ('c', 'perl', 'python'), 'Works for first example';
    is sort-language(['c++', 'haskell', 'java'], [1, 3, 2]),
        ('c++', 'java', 'haskell'), 'Works for second example';
}
