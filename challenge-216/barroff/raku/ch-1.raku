#!/usr/bin/env raku

use v6.d;

sub is-superset(Set $reg, Str $word --> Bool) {
    my Set $word-set = $word.lc.comb.Set;
    $reg (&) $word-set == $reg ?? True !! False;
}

sub registration-number(Str @words, Str $reg --> List) {
    my Set $characters = $reg.lc.comb.grep({ $_ ~~ /<:L>/ }).Set;
    return grep({ is-superset($characters, $_) }, @words).List;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is registration-number(Array[Str].new('abc', 'abcd', 'bcd'), 'AB1 2CD'),
        ('abcd'), "works for ('abc', 'abcd', 'bcd')";
    is registration-number(Array[Str].new('job', 'james', 'bjorg'), '007 JB'),
        ('job', 'bjorg'), "works for ('job', 'james', 'bjorg')";
    is registration-number(Array[Str].new('crack', 'road', 'rac'), 'C7 RA2'),
        ('crack', 'rac'), "works for ('crack', 'road', 'rac')";
}
