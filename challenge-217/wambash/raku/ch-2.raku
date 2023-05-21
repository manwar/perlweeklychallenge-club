#!/usr/bin/env raku

sub max-number (+@list) {
    my $max-length =  .max div .min + 1 with @list».codes.minmax;

    @list
    andthen .sort: *.Str x $max-length
    andthen .reverse
    andthen .join
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-number(1, 12, 101), '121101';
    is max-number(1, 23), '231';
    is max-number(10, 3, 2), '3210';
    is max-number(31, 2, 4, 10), '431210';
    is max-number(5, 11, 4, 1, 2), '542111';
    is max-number(1,10), '110';
    done-testing;
}

multi MAIN (*@list) {
    say max-number @list
}
