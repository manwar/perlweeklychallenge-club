=begin

TASK #1 › Chinese Zodiac
Submitted by: Mohammad S Anwar
You are given a year $year.

Write a script to determine the Chinese Zodiac for the given year $year. Please check out wikipage for more information about it.

The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey, Rooster, Dog, Pig.
The element cycle: Wood, Fire, Earth, Metal, Water.

Example 1:
    Input: 2017
    Output: Fire Rooster
Example 2:
    Input: 1938
    Output: Earth Tiger

=end
=cut

#Firt year to start: 1924 wood rat

use strict;
use warnings;
use Data::Dumper;

my @animals = qw(Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig);

my $i;
my $year = 2017;
my $counter = 0;

calculateElement();

sub calculateElement {
    my ($lastChar) = $year =~ /(.?)$/;

    if ($lastChar == 0 or $lastChar == 1) {
        print "Metal ";
    }
    elsif ($lastChar == 2 or $lastChar == 3) {
        print "Water ";
    }
    elsif ($lastChar == 4 or $lastChar == 5) {
        print "Wood ";
    }
    elsif ($lastChar == 6 or $lastChar == 7) {
        print "Fire ";
    }
    else {
        print "Earth ";
    }
    calculateAnimal();
}

sub calculateAnimal {
    for ($i = 1924; $i<$year; $i++){
        if ($counter == 11){
            $counter = 0;
        }
        else {
            $counter++;
        }
    }
    print "$animals[$counter]";
}
