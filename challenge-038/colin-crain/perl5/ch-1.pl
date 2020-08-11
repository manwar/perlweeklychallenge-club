#! /opt/local/bin/perl
#
#        datefinder.pl
#
#        TASK #1
#         Date Finder
#             Create a script to accept a 7 digits number, where the first number
#             can only be 1 or 2. The second and third digits can be anything 0-9.
#             The fourth and fifth digits corresponds to the month i.e.
#             01,02,03…,11,12. And the last 2 digits respresents the days in the
#             month i.e. 01,02,03….29,30,31. Your script should validate if the
#             given number is valid as per the rule and then convert into human
#             readable format date.
#
#             RULES
#                 1) If 1st digit is 1, then append 20 otherwise 19 to the 2nd and
#                    3rd digits to make it 4-digits year.
#
#                 2) The 4th and 5th digits together should be a valid month.
#
#                 3) The 6th and 7th digits together should be a valid day for the
#                    above month.
#
#             For example, the given number is 2230120, it should print 1923-01-20.
#
#             method: the basic format can be validated with a single regex,
#                 matching only valid combinations of numbers: 1 or 2, then 00-99,
#                 then 01-12, then 01-31, seven digits total. At the same time
#                 capture groups can gather the first digit, 2 digit year, month
#                 and day fields. The first digit can be normallized by
#                 subtracting from 21 and multiplying by 100 before summing with
#                 the second two.
#
#                 After this all that remains is to validate the date. An array of
#                 days in the month can make sure the day is in range for that
#                 month. A quick and dirty check routine can verify whether any
#                 given Feb 29, presumed valid until this point, falls within a
#                 leap year. A little sugar provides a month abbreviation instead
#                 of number, avoiding any confusion about international date ordering.
#
#        2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $input = shift @ARGV;

if ( ! defined $input ) {
    say "please input a number to validate";
    exit;
}

unless ( $input =~ /^ ([12])                     ## (start string) 1 or 2
                      (\d\d)                    ## 00-99
                      (0[1-9]|1[0-2])           ## 01-09 or 10-12
                      (0[1-9]|[12]\d|3[01])     ## 01-09 or 10-29 or 30-31 (end string)
                    $/x ) {                        ## x for whitespace
    say "failed: numeric validation : $input";
    exit;
}

my $y = (21 - $1) * 100 + $2;
my $m = $3;
my $d = $4;

my @mlen    = ( 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
my @mname = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

if ( $d > $mlen[$m-1] ) {
    say "failed: the month of $mname[$m-1] doesn't have $d days! : $input";
    exit;
}

if ( $m == 2 && $d == 29 ) {
    is_leap( $y )   ? say "passed: $mname[$m-1] $d, $y"
                    : say "failed: $y is not a leap year : $input";
}
else {
    say "passed: $mname[$m-1] $d, $y";
}


## ## ## ## ## SUBS

sub is_leap {
## returns true if leap year
# 1: if the year is evenly divisible by 4,   go to step 2. else, return 0.
# 2: if the year is evenly divisible by 100, go to step 3. else, return 1.
# 3: if the year is evenly divisible by 400, return 1.     else, return 0.
    my $y = shift;
    unless ($y % 4 == 0)   { return 0 }
    unless ($y % 100 == 0) { return 1 }
    unless ($y % 400 == 0) { return 0 }
    return 1;
}
