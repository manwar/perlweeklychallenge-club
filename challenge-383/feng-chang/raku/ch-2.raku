#!/bin/env raku

unit sub MAIN(Str:D $color);

my method round-color(Str:D $s :) {
    round($s.parse-base(16), 51).fmt('%02X')
}

with $color {
    put '#',
        .substr(1, 2).&round-color,
        .substr(3, 2).&round-color,
        .substr(5, 2).&round-color;
}
