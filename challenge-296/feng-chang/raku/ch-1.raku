#!/bin/env raku

unit sub MAIN(
    Str:D  $s is copy,
    Bool:D :d($decompress) = False,
);

if !$decompress {
    while $s ~~ s/(<[a..z]>) $0+/{ $/.chars ~ $0 }/ { };
} else {
    while $s ~~ s/(\d+) (<[a..z]>)/{ $1 x $0 }/ { };
}
put $s;
