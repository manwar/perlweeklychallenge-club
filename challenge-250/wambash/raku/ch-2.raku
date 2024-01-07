#!/usr/bin/env raku



multi string-value-max ( +alphanumeric-string ) {
    alphanumeric-string
    andthen .map: { try { .Int  } // .chars }\
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is string-value-max(<perl 2 000 python r4ku>), 6;
    is string-value-max(<001 1 000 0001>), 1;
    done-testing;
}

multi MAIN (+alpahnumeric-string) {
    say string-value-max  alpahnumeric-string
}
