#!/usr/bin/env raku

use v6.d;

sub intermingle-arrays(@arr1, @arr2 --> Str) {
    return map(
        { @arr1[$_] ~ @arr2[$_] },
        0..^@arr1.elems
    ).join;
}

sub balance-string(Str $str --> Str) {
    my @letters = grep({ /^ <:Ll> $/ }, $str.comb).sort;
    my @numbers = grep({ /^ \d $/ }, $str.comb).sort;
    my Int $occurence-diff = @letters.elems - @numbers.elems;
    given $occurence-diff {
        when 0 {
            intermingle-arrays(@numbers, @letters);
        }
        when 1 {
            my Str $pairs = intermingle-arrays(@letters[0..*-2], @numbers);
            return $pairs ~ @letters[*-1];
        }
        when -1 {
            my Str $pairs = intermingle-arrays(@numbers[0..*-2], @letters);
            return $pairs ~ @numbers[*-1];
        }
        default {
            return "";
        }
    }
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 5;

    is balance-string("a0b1c2"), "0a1b2c", 'works for "a0b1c2"';
    is balance-string("abc12"), "a1b2c", 'works for "abc12"';
    is balance-string("0a2b1c3"), "0a1b2c3", 'works for "0a2b1c3"';
    is balance-string("1a23"), "", 'works for "1a23"';
    is balance-string("ab123"), "1a2b3", 'works for "ab123"';
}

#| Take user provided string like a0b1c2
multi sub MAIN(Str $str) {
    say balance-string($str);
}

