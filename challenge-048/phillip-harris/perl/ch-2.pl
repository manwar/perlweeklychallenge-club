#!/usr/bin/perl
# Palindrome Dates
# Write a script to print all Palindrome Dates between 2000 and 2999.
# The format of date is mmddyyyy. For example, the first one was on
# October 2, 2001 as it is represented as 10022001.

# My first attempt used Date::Time to add one day to a date object and check
# for palindrome on each loop but it was very slow. Generating potentially
# invalid dates with nested loops and checking date validity only when a
# palindrome is found turned out to be much faster.

use Date::Calc qw(check_date);

$year  = 2000;
$month = 1;
$day   = 1;

for ( $year = 2000 ; $year <= 2999 ; $year++ ) {
    for ( $month = 1 ; $month <= 12 ; $month++ ) {
        for ( $day = 1 ; $day <= 31 ; $day++ ) {
            $md = sprintf( "%02d%02d", $month, $day );
            if ( $md eq reverse($year) ) {
                if ( check_date( $year, $month, $day ) ) {
                    print "$md$year\n";
                }
            }
        }
    }
}
