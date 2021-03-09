#!/usr/bin/env raku

use Test;
plan 11;

is zodiac(1924), "Wood Rat";
is zodiac(1938), "Earth Tiger";
is zodiac(1942), "Water Horse";
is zodiac(1966), "Fire Horse";
is zodiac(1984), "Wood Rat";
is zodiac(1999), "Earth Rabbit";
is zodiac(2001), "Metal Snake";
is zodiac(2012), "Water Dragon";
is zodiac(2017), "Fire Rooster";
is zodiac(2021), "Metal Ox";
is zodiac(2025), "Wood Snake";

sub zodiac(UInt $year is copy) 
{
    $year -= 1900;

    my @elements = flat map { $_ xx 2 }, < Metal Water Wood Fire Earth >;

    my @animals  = < Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig >;

    @elements[$year mod 10], @animals[$year mod 12] andthen .join(" ");
}
