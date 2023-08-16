use v5.38;
##
# You are given a year number in the range 1753 to 9999.
# Write a script to find out how many dates in the year are Friday 13th.
##
use Getopt::Long;

use constant JANUARY => 1;
use constant FEBRUARY => 2;
use constant DECEMBER => 12;

use constant FRIDAY => 5;  

sub month_name{
    my($m) = @_; 
    return qw/January February March April May June July August September October November 
              December/[$m - 1];
} 
 
sub day_of_week{
    my($year, $month, $day) = @_;
    my @month_value = (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4); 
    $year-- if($month == JANUARY || $month == FEBRUARY);  
    return ($year + int($year / 4) - int($year / 100) + int($year / 400) + $month_value[$month - 1] + $day) % 7
}


MAIN:{
    my($year);
    GetOptions(qq/year=i/ => \$year);
    my $day = 13;
    my $friday_13ths;
    my $is_leap_year = ((($year % 4) == 0) && (($year % 100) != 0)) || (($year % 4) == 0 && ($year % 400) == 0); 
    for my $month (JANUARY .. DECEMBER){        
        my $dow = day_of_week($year, $month, $day);
        if($dow == FRIDAY){
            $friday_13ths++; 
            say month_name($month) . q/ / . $day;     
        }      
    }
    say qq/Friday the 13ths in $year: $friday_13ths/;
} 