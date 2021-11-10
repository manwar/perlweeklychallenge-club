#!perl.exe

### Author: Robert DiCicco
### Date: 8-NOV-2021
### Challenge #: 138  Workdays.pl

use strict;
use warnings;

use Date::Calc qw(:all);
use IO::Prompter;

my $input_yr = prompt 'Input year = ', -num;
my $numyr = Days_in_Year($input_yr,12);

my ($count, $dow) = 0;
for my $offset (1 .. $numyr){
    #Starting with last day of previous year
    # add 1, then calculate date
    my ($year,$month,$day) = Add_Delta_Days(($input_yr - 1),12,31,$offset);
    $dow = Day_of_Week($year,$month,$day);  # then, get its day of week
    if(($dow > 0 ) && ($dow < 6)){   ## 0 = Sunday,  6 = Saturday
        $count++;
    }
}

print("Output: $count\n");
