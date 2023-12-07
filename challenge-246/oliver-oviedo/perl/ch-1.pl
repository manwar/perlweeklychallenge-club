#!/usr/bin/perl

#CHALLENGE #246

#Write a script that outputs six unique random integers from the range 1 to 49.

use strict;
use warnings;

my $randomNumber = int(rand(50));
my @randomArray;

for (my $i; $i <= 6; $i++){
    my $randomNumber = int(rand(50));
    if (!exists($randomArray[$randomNumber])){
        push (@randomArray,$randomNumber);
    }
    print "@randomArray\n";
}
