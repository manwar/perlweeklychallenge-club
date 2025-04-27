#!/usr/bin/env raku

use v6.d;

sub group-position(Str $str) {
    my Str @chr = $str.comb;
    my @result;
    my Int $count = 0;
    my Str $prev = "";
    for @chr -> $c {
        if $c eq $prev {
            $count++;
        } else {
            @result.push($prev x $count) if $count > 2;
            $count = 1;
        }

        $prev = $c;
    }

    @result.push($prev x $count) if $count > 2;
    @result ?? @result !! "";
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is group-position("abccccd"), ["cccc"], 'works for "abccccd"';
    is group-position("aaabcddddeefff"), ["aaa", "dddd", "fff"],
        'works for "aaabcddddeefff"';
    is group-position("abcdd"), "", 'works for "abcdd"';
}

#| Take user provided string "abccccd"
multi sub MAIN(Str $str) {
    say group-position($str);
}
