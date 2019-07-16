#!/usr/bin/perl6
use v6;

use Test;

# 16.1
# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
#
# At a party a pie is to be shared by 100 guest. The first guest gets 1% of the pie, the second guest gets 2% of the remaining pie, the third gets 3% of the remaining pie, the fourth gets 4% and so on.
#
# Write a script that figures out which guest gets the largest piece of pie.


#| Figures which guests is the happy party pie guest.
multi sub MAIN($guests=100) {
    my $pie=1.0;
    my $biggestSlice=0;
    my $fattestGuest=Nil;
    for 1..$guests -> $g {
        my $slice=$pie*($g/100);
        $pie-=$slice;
        if $slice>$biggestSlice {
            $fattestGuest=$g;
            $biggestSlice=$slice;
        }
        say "guest {$g} gets $slice of the pie";
    }
    say "guest {$fattestGuest} gets the largest slice $biggestSlice";

};

multi sub MAIN("test") {

    done-testing;
}

