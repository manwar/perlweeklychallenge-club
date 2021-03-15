use strict;
use warnings;
##
# You are given a year $year.
# Write a script to determine the Chinese Zodiac for the given year $year
##
use constant ELEMENTS => {1 => q/Wood/, 2 => q/Fire/, 3 => q/Earth/, 4 => q/Metal/, 0 => q/Water/};
use constant ANIMALS =>  {1 => q/Rat/, 2 => q/Ox/, 3 => q/Tiger/, 4 => q/Rabbit/, 5 => q/Dragon/, 6 => q/Snake/, 7 => q/Horse/, 8 => q/Goat/, 9 => q/Monkey/, 10 => q/Rooster/, 11 => q/Dog/, 0 => q/Pig/}; 

sub chinese_zodiac{
    my($year) = @_;
    return ELEMENTS->{$year % 5} . " " . ANIMALS->{($year + 9) % 12};    
} 

MAIN:{
    my($YEAR);
    $YEAR = 2017;
    print chinese_zodiac($YEAR) . "\n";
    $YEAR = 1938;
    print chinese_zodiac($YEAR) . "\n";
}  
