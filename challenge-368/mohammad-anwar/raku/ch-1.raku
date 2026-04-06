#!/usr/bin/env raku

use Test;

my @examples = (
    { s => "15456",  c => "5", o => "1546"  },
    { s => "7332",   c => "3", o => "732"   },
    { s => "2231",   c => "2", o => "231"   },
    { s => "543251", c => "5", o => "54321" },
    { s => "1921",   c => "1", o => "921"   },
);

for @examples -> $ex {
    is make-it-bigger($ex<s>, $ex<c>), $ex<o>;
}

done-testing;

sub make-it-bigger($s, $c) {
    return (0..$s.chars-1).map({
        $s.substr($_, 1) eq $c
            ?? ($s.substr(0, $_) ~ $s.substr($_ + 1))
            !! Empty
    }).max;
}
