use strict;
use warnings;
##
# Write a script to print the date of last Friday of every month of a given year.
##
use constant YEAR => 2019; 
use constant FRIDAY => 5; 
use constant JANUARY => 1;
use constant FEBRUARY => 2;
use constant MARCH => 3;
use constant APRIL => 4;
use constant MAY => 5;
use constant JUNE => 6;
use constant JULY => 7;
use constant AUGUST => 8;
use constant SEPTEMBER => 9;
use constant OCTOBER => 10;
use constant NOVEMBER => 11;
use constant DECEMBER => 12;
 
sub day_of_week{
    my($year, $month, $day) = @_;
    my @month_value = (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4); 
    $year-- if($month == JANUARY || $month == FEBRUARY);  
    return ($year + int($year/4) - int($year/100) + int($year/400) + $month_value[$month-1] + $day) % 7
}

##
# Main
##
my $is_leap_year = (((YEAR % 4) == 0) && ((YEAR % 100) != 0)) || ((YEAR % 4) == 0 && (YEAR % 400) == 0); 
for my $m (JANUARY..DECEMBER){
    my $last_friday; 
    for my $d (20 .. 31){
        last if($m == FEBRUARY && $d > 28 && !$is_leap_year);
        last if($m == FEBRUARY && $d > 29 && $is_leap_year);
        last if(($m == APRIL || $m == JUNE || $m == SEPTEMBER || $m == NOVEMBER) && $d > 30); 
        my $dow = day_of_week(YEAR, $m, $d);
        if($dow == FRIDAY){
            $last_friday = $d;    
        }   
    }  
    print YEAR . "/" . sprintf("%02d", $m) . "/$last_friday\n";
} 
