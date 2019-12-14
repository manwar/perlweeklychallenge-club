use strict;
use warnings;
##
# Write a script to calculate the total number of 
# weekdays (Monday-Friday) in each month of the year 2019.
##
use constant YEAR => 2019; 

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

use constant SATURDAY => 6;  
use constant SUNDAY => 0; 

sub month_name{
    my($m)= @_; 
    return "January" if $m == 1; 
    return "February" if $m == 2; 
    return "March" if $m == 3; 
    return "April" if $m == 4; 
    return "May" if $m == 5; 
    return "June" if $m == 6; 
    return "July" if $m == 7; 
    return "August" if $m == 8; 
    return "September" if $m == 9; 
    return "October" if $m == 10; 
    return "November" if $m == 11; 
    return "December" if $m == 12; 
} 
 
sub day_of_week{
    my($year, $month, $day) = @_;
    my @month_value = (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4); 
    $year-- if($month == JANUARY || $month == FEBRUARY);  
    return ($year + int($year/4) - int($year/100) + int($year/400) + $month_value[$month-1] + $day) % 7
}


MAIN:{
    my $weekdays;
    my $is_leap_year = (((YEAR % 4) == 0) && ((YEAR % 100) != 0)) || ((YEAR % 4) == 0 && (YEAR % 400) == 0); 
    for my $month (JANUARY..DECEMBER){
        for my $day (1 .. 31){
            last if($month == FEBRUARY && $day > 28 && !$is_leap_year);
            last if($month == FEBRUARY && $day > 29 && $is_leap_year);
            last if(($month == APRIL || $month == JUNE || $month == SEPTEMBER || $month == NOVEMBER) && $day > 30); 
            my $dow = day_of_week(YEAR, $month, $day);
            if($dow != SATURDAY && $dow != SUNDAY){
                $weekdays++;     
            }   
        }  
        print month_name($month) . ": $weekdays days\n";  
        $weekdays = 0;
    }
} 
