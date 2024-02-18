#!/usr/bin/env raku

sub maximum-pairs (+words) {
    words
    andthen .combinations: 2
    andthen .map: -> ( $fw, $sw ) { $fw eq $sw.flip }\
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
