#!/usr/bin/env raku

sub word-break ($str, +@words) {
    $str.contains: /^ @words+ $/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is word-break('weeklychallenge', 'challenge','weekly'), True;
    is word-break('perlrakuperl', 'perl','raku'), True;
    is word-break('sonsanddaughters', 'sons', 'sand', 'daughters'), False;
    is word-break('sonssanddaughters', 'sons', 'sand', 'daughters'), True;
    done-testing;
}

multi MAIN ($str, +words) {
    say word-break $str, words
}
