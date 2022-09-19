#!/usr/bin/perl

# Created for perl weekly challenge - 178
# used strawberry perl 5.32

use strict;
use warnings;

use feature 'say';
use DateTime;

use constant
{
    MON => 1, TUE => 2,    WED => 3,    THU => 4,    FRI => 5,    SAT => 6,    SUN => 7,   
};



sub calcDuration
{
    my $duration = shift;
    
    # calculate the duration
    my $day      = int($duration / 24);
    my $hour     = int($duration % 24);
    my $min      = int( ($duration - int($duration) ) * 60);      #   converting from decimal minute

    return $day, $hour, $min;
}

sub createDateObj
{
    my ($year, $month, $day, $hour, $min ) = @_;
    
    my $dateObj = DateTime->new(
        year        => $year,
        month       => $month,
        day         => $day,
        hour        => $hour,
        minute      => $min,
        second      => 0,
        nanosecond  => 0,
    );

    return $dateObj;
}

sub businessDate
{
    my ($date, $duration) = @_;
    
    # calculate the duration
    my ($durDay, $durHour, $durMin ) = calcDuration($duration);

    # match the element of the date from the given
    my ($curYear, $curMonth, $curDay, $curHour, $curMin ) = (   $date =~ m/^(\d{4})  -  (\d{2}) -  (\d{2})  \s*  (\d{2}) :   (\d{2}) $/x );

    # creating object to hold the the start date
    my $CurrentTime = createDateObj($curYear, $curMonth, $curDay, $curHour, $curMin);

    # printing out info
    say("Given timestamp", " " x 22, $CurrentTime->ymd,"  ", $CurrentTime->hms, " Given duration is $duration");

    # calculate the minute
    my $endMin = $curMin + $durMin;

    if($endMin > 59)
    {
        $durHour++;
        $endMin -= 60;
        
    }

    # calculate the hour
    my $endHour = $curHour + $durHour;

    while($endHour > 17)
    {
        $durDay++;
        $endHour = 9 + ( $endHour - 18);
    }

    # creating the end time object
    my $EndTime = createDateObj($curYear, $curMonth, $curDay, $endHour, $endMin);


    # add days to the endtime, skip the weekends
    for(my $i = 0; $i < $durDay; $i++ )
    {

        if( ($EndTime->day_of_week) == FRI )
        {
            $EndTime->add( days => 3 );
        }
        elsif( ($EndTime->day_of_week) == SAT )
        {
            $EndTime->add( days => 2 );
        }
        else
        {
            $EndTime->add( days => 1 );
        }
    }

    say("Then the next business date would be ", $EndTime->ymd,"  ", $EndTime->hms);
}



#sample call 
# businessDate("2022-08-01 10:30", 4);

#sample call 2
# businessDate("2022-08-01 17:00", 3.5);

