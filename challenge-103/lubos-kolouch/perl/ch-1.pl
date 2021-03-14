#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 103
#               Task 1 - Chinese Zodiac
#
#       AUTHOR: Lubos Kolouch 
#      CREATED: 03/13/2021 11:06:43 AM
#===============================================================================

use strict;
use warnings;


sub get_zodiac {
    my $year = shift;

    my @animals = ('Rat', 'Ox', 'Tiger', 'Rabbit', 'Dragon', 'Snake', 'Horse', 'Goat', 'Monkey', 'Rooster', 'Dog', 'Pig');

    my @elements = ('Wood', 'Fire', 'Earth', 'Metal', 'Water');

    my $year_diff;
    my $elem_diff;

    # 1924 was chosen just because of the wiki entry
    # ignoring Julian calendar

    if ($year >= 1924) {
        $year_diff = ($year-1924) % scalar @animals;
        $elem_diff = int(($year-1924) / 2) % scalar @elements;
    } else {
        # 1923 => 5  diff 2 / 2 = 1 - 1 = 0
        # 1922 => 5  diff 3 / 2 = 1 - 1 = 0
        # 1921 => 4  diff 4 / 2 = 2 - 1 = 1
        # 1920 => 4  diff 5 / 2 = 2 - 1 = 1
        # 1919 => 3  diff 6 / 2 = 3 - 1 = 2
        # 1913 =>    diff 12 / 2 = 6 - 1 = 5
        # 1910 =>    diff 15 / 2 = 7 - 1 = 6 = 1 = 4

        $year_diff = -((1924-$year) % scalar @animals);
        
        $elem_diff = (1925-$year);
        $elem_diff = int($elem_diff / 2) - 1;
        $elem_diff = $elem_diff % 5;
        $elem_diff = 5 - $elem_diff;                
        $elem_diff -= 1;
    }

    return $elements[$elem_diff].' '.$animals[$year_diff];
}

use Test::More;
is(get_zodiac(1804), 'Wood Rat');
is(get_zodiac(1845), 'Wood Snake');
is(get_zodiac(1910), 'Metal Dog');
is(get_zodiac(1923), 'Water Pig');
is(get_zodiac(1924), 'Wood Rat');
is(get_zodiac(1925), 'Wood Ox');
is(get_zodiac(1926), 'Fire Tiger');
is(get_zodiac(1927), 'Fire Rabbit');
is(get_zodiac(1934), 'Wood Dog');
is(get_zodiac(1938), 'Earth Tiger');
is(get_zodiac(1976), 'Fire Dragon');
is(get_zodiac(2017), 'Fire Rooster');


done_testing;
