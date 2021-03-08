#!/usr/bin/perl
use warnings;
use strict;

my @ANIMALS  = qw( Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey
                   Rooster Dog Pig );
my @ELEMENTS = qw( Wood Fire Earth Metal Water );

my %START = (ANIMAL => 8, ELEMENT => 6);

sub chinese_zodiac {
    my ($year) = @_;
    return join ' ', $ELEMENTS[ ($year + $START{ELEMENT}) / 2 %  5 ],
                     $ANIMALS[  ($year + $START{ANIMAL})      % 12 ]
}

use Test::More tests => 6;

is chinese_zodiac(2017), 'Fire Rooster', 'Example 1';
is chinese_zodiac(1938), 'Earth Tiger',  'Example 2';

is chinese_zodiac(1924), 'Wood Rat',  'start of the cycle';
is chinese_zodiac(1925), 'Wood Ox'  , 'start of the cycle + 1';
is chinese_zodiac(1982), 'Water Dog', 'end of the cycle - 1';
is chinese_zodiac(1983), 'Water Pig', 'end of the cycle';
