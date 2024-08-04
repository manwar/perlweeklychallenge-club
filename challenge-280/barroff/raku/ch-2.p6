#!/usr/bin/env raku

use v6.d;

sub count-asterisks(Str $str --> Int) {
    my $pairless = $str.subst(/\|.*?\|/, :g);
    grep({ $_ eq '*' }, $pairless.comb).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is count-asterisks("p|*e*rl|w**e|*ekly|"), 2,
        'works for "p|*e*rl|w**e|*ekly|"';
    is count-asterisks("perl"), 0, 'works for "perl"';
    is count-asterisks("th|ewe|e**|k|l***ych|alleng|e"), 5,
        'works for "th|ewe|e**|k|l***ych|alleng|e"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(Str $str) {
    say count-asterisks($str);
}
