#!/bin/env raku

unit sub MAIN(*@words);

my $snt = @words.pop;
put $snt.words.map(-> \w {
    with @words.first({ w.starts-with($_) }) { $_ }
    else { w }
}).join(' ');
