#!/usr/bin/env raku

sub find-words (+list, :$char) {
    list.grep: *.contains($char), :k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is find-words(<the weekly challenge>):char<e>,(0,1,2);
    is find-words(<perl raku python>):char<p>,(0,2);
    is find-words(<abc def bbb bcd>):char<b>,(0,2,3);
    done-testing;
}

multi MAIN (+list, :$char) {
     put find-words list, :$char
}
