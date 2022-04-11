#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @table = (
    [ "zero",  4 ],
    [ "one",   3 ],
    [ "two",   3 ],
    [ "three", 5 ],
    [ "four",  4 ],
    [ "five",  4 ],
    [ "six",   3 ],
    [ "seven", 5 ],
    [ "eight", 5 ],
    [ "nine",  4 ]
);
my @numbers = ( 5, 7, 6 );
my $number;

print("\n");
foreach $number (@numbers){
    unless(($number > -1) && ($number < 10)){
        warn("Invalid number $number\n\n");
        next;
    }

    my $string = "";

    print("Input: \$n = ", $number, "\n");
    print("Output: ");
    until($number == 4){
        # This number isn't four; add its count details
        # and advance to the next number
        $string .= 
            $table[$number][0] .
            " is " .
            $table[$table[$number][1]][0] .
            ", ";
        $number = $table[$number][1];
    }
    
    # We must have hit four, so add the magical
    # sentiment, upper-case what's first, and
    # output...
    $string .= "four is magic.";
    $string =~ s/^(.)/uc($1)/e;
    print($string, "\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



