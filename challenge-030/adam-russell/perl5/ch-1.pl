use strict;
use warnings;
##
# Write a script to list dates for Sunday Christmas between 2019 and 2100.
## 
sub day_of_week{
    my($year, $month, $day) = @_;
    my @month_value = (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4); 
    $year-- if($month == 1 || $month == 2);  
    return ($year + int($year/4) - int($year/100) + int($year/400) + $month_value[$month-1] + $day) % 7
}

MAIN:{ 
    for my $year (2019 .. 2100){
        my $is_leap_year = ((($year % 4) == 0) && (($year % 100) != 0)) || (($year % 4) == 0 && ($year % 400) == 0); 
        my $dow = day_of_week($year, 12, 25);
        print "$year\n" if $dow == 0; 
    }
}   
