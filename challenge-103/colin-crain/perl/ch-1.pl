#! /opt/local/bin/perl
#
#       metal-monkey-man.pl
#       sexy-zodiac.pl
#
#         TASK #1 › Chinese Zodiac
#         Submitted by: Mohammad S Anwar
#         You are given a year $year.
# 
#         Write a script to determine the Chinese Zodiac for the given year
#         $year. Please check out wikipage for more information about it.
# 
#         The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat,
#         Monkey, Rooster, Dog, Pig.

#         The element cycle: Wood, Fire, Earth, Metal, Water.
# 
#         Example 1:
#             Input: 2017
#             Output: Fire Rooster
#         Example 2:
#             Input: 1938
#             Output: Earth Tiger

        
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
our $TESTS = 1;


our @elements   = qw(   Wood    Fire    Earth   Metal   Water );
our @animals    = qw(   Rat     Ox      Tiger 
                        Rabbit  Dragon  Snake 
                        Horse   Goat    Monkey 
                        Rooster Dog     Pig) ;
our @energy     = qw(   Yin Yang );
       

say zodiac($_) for @ARGV;

sub zodiac($year) {
    my $sy = sexagenary_year($year);
    my $animal = animal($sy);
    my $element = element($sy);
    my $energy = energy($sy);
    
    my $out =  "$year : $energy $element $animal";
    
    return $out;                            ## testing

}

sub sexagenary_year( $year, $era = '' ) {
## Gregorian year --> Sexagenary year
## divided into AD/A.D./CE/C.E. and BC/B.C./C/BCE/B.C.E.
## no mark is of course assumed to be CE
## SY 60 is returned as 0.

    ($year, $era) = $year =~ /^(\d+)\s?([ABC]?)/i;
    if ( not $era or $era eq 'A' or $era eq 'C' ) {
        return 58 if $year == 1;
        return 59 if $year == 2;
        return 0  if $year == 3;
        return ($year - 3) % 60; 
    }
    else {
        return 60 - abs($year+2) % 60;
    }
}

sub animal( $sexy_year ) {
## 12-year cycle, 1-based
## SY goes 1-59, 0
    my $idx = ($sexy_year-1) % 12 ;
    return $animals[ $idx ];

}

sub element( $sexy_year ) {
## 10-year cycle of 5 x 2-year periods
    my $idx = int ( ($sexy_year-1) % 10 ) / 2;
    return $elements[$idx];

}

sub energy( $sexy_year ) {
## alternating yin and yang repetition
    my $idx = $sexy_year % 2;
    return $energy[$idx];

}






exit unless $TESTS;

use Test::More;

is sexagenary_year(1964), 41, "year 1964 -> 41";
is sexagenary_year(2021), 38, "year 2021 -> 38";

is animal(41),      'Dragon',   'animal  1964';
is element(41),     'Wood',     'element 1964';
is energy(41),      'Yang',     'energy 1964';

is animal(42),      'Snake',    'animal  1965';
is element(42),     'Wood',     'element 1965';
is energy(42),      'Yin',      'energy 1965';

is animal(43),      'Horse',    'animal  1966';
is element(43),     'Fire',     'element 1966';
is energy(43),      'Yang',     'energy 1966';

is animal(0),       'Pig',      'animal  SY0';
is element(0),      'Water',    'element SY0';
is energy(0),       'Yin',      'energy SY0';

is sexagenary_year(1924),   1,      "year 1924 -> SY1";
is animal(1),       'Rat',      'animal  1924';
is element(1),      'Wood',     'element 1924';
is energy(0),       'Yin',      'energy 1924';

is sexagenary_year(1983),   0,      "year 1983 -> 60 -> 0";

is sexagenary_year('246 BC'),   52,      "year 246 BC";
is animal(52),      'Rabbit',   'animal  246 BC';
is element(52),     'Wood',     'element 246 BC';
is energy(0),       'Yin',      'energy 246 BC';

is sexagenary_year('1 BC'),  0 ,      "year 1 BCE";

is zodiac(1964), "1964 : Yang Wood Dragon", "zodiac year 1964";


done_testing();
