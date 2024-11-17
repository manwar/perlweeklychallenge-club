#!/usr/bin/env raku

use v6.d;

sub word-break(Str $str, @words --> Bool) {
    return True if $str ∈ @words;
    my @starters = grep({ $str.starts-with($_) }, @words);
    if @starters {
        my @l = map({ word-break($str.comb[$_.chars..*-1].join, @words) }, @starters);
        return so True == @l.any;
    }
    return False;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is word-break("weeklychallenge", ["challenge", "weekly"]), True,
        'works for "weeklychallenge"';
    is word-break("perlrakuperl", ["raku", "perl"]), True,
        'works for "perlrakuperl"';
    is word-break("sonsanddaughters", ["sons", "sand", "daughters"]), False,
        'works for "sonsanddaughters"';
}

#| Take user provided number like "Perl Weekly Challenge" l a
multi sub MAIN(Str $sentence, *@keys) {
    say word-break($sentence, @keys);
}
