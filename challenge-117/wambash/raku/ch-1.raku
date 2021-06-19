#!/usr/bin/env raku

sub missing-row (@lines, :$expected = 1..15 ) {
    @lines
    andthen .map: *.split: ',', 2
    andthen .map: *.[0].Int
    andthen $expected ∖ $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    my @lines = '
    11, Line Eleven
    1, Line one
    9, Line Nine
    13, Line Thirteen
    2, Line two
    6, Line Six
    8, Line Eight
    10, Line Ten
    7, Line Seven
    4, Line Four
    14, Line Fourteen
    3, Line three
    15, Line Fifteen
    5, Line Five
    '.lines;

    is missing-row(@lines), 12;
    done-testing;
}

multi MAIN () {
    put missing-row $*IN.lines
}
