#!/usr/bin/env raku

sub maximum-pairs (+words) {
    words.kv
    andthen .map: -> $i, $w { [+] $w.flip «eq« words.skip: $i + 1  }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximum-pairs(<ab de ed bc>),1;
    is maximum-pairs(<aa ba cd ed>),0;
    is maximum-pairs(<uv qp st vu mn pq>),2;
    done-testing;
}

multi MAIN (+words) {
    say maximum-pairs words
}
