#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-07-08
# Week: 016
#
# Task #1
# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
#
# At a party a pie is to be shared by 100 guest. The first guest gets 1%
# of the pie, the second guest gets 2% of the remaining pie, the third
# gets 3% of the remaining pie, the fourth gets 4% and so on.
#
# Write a script that figures out which guest gets the largest piece of
# pie.

use strict;
use warnings;
use feature qw/ say /;

my $pie                  = 360;
my $current_guest        = 1;
my $guest_with_max_share = 1;
my @share_of_pie;

while ( $pie != 0 ) {
    my $current_share = $pie * ( $current_guest / 100 );
    $pie -= $current_share;
    $share_of_pie[$current_guest] = $current_share;
    if ( $share_of_pie[$guest_with_max_share] < $current_share ) {
        $guest_with_max_share = $current_guest;
    }
    $current_guest++;
}

say "Guest $guest_with_max_share gets the largest piece of the pie.";
