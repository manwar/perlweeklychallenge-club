#!/usr/bin/env raku

constant @animal  = < Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig >;
constant @element =  <Yang Ying> RXR~ ' ' RXR~ <Wood Fire Earth Metal Water>;
constant @sexagenary-cycle = |@element xx 6 Z~ ' ' xx * Z~ |@animal xx 5;

sub chinese-zodiac ( $year ) {
    @sexagenary-cycle.[($year-4) mod 60];
}

multi MAIN (UInt $year ) {
    say chinese-zodiac $year
}

multi MAIN (Bool :$test! ) {
    use Test;
    is chinese-zodiac(2017), 'Ying Fire Rooster';
    is chinese-zodiac(1938), 'Yang Earth Tiger';
    done-testing;
}
