#!/usr/bin/env raku

sub max-str-value (+strings) {
    strings
    andthen .map: { Num($_) // .chars }\
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-str-value(<123 45 6>), 123;
    is max-str-value(<abc de fghi>), 4;
    is max-str-value(<0012 99 a1b2c>), 99;
    is max-str-value(<x 10 xyz 007>), 10;
    is max-str-value(<hello123 2026 perl>), 2026;
    done-testing;
}

multi MAIN (+strings) {
    say max-str-value strings;
}
