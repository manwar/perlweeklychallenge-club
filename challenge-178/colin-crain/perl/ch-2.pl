#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       busy-dating-service.pl
#
#       Business Date
#         Submitted by: Mohammad S Anwar
#         You are given $timestamp (date with time) and $duration in hours.
# 
#         Write a script to find the time that occurs $duration business
#         hours after $timestamp. For the sake of this task, let us assume
#         the working hours is 9am to 6pm, Monday to Friday. Please ignore
#         timezone too.
# 
#         For example,
# 
#         Suppose the given timestamp is 2022-08-01 10:30 and the duration
#         is 4 hours. Then the next business date would be 2022-08-01
#         14:30.
# 
#         Similar if the given timestamp is 2022-08-01 17:00 and the
#         duration is 3.5 hours. Then the next business date would be
#         2022-08-02 11:30.

#       Analysis:
# 
#         There's alot of moving parts to this particular challenge. We
#         need to start with inputting a timestamp string, and then add
#         hours to it, carrying over into the next day as required until we
#         land within the business hours of a single day. Weekends are
#         excluded as well, so if we roll off Friday we resume Monday
#         morning. And of course we're only counting the hours elapsed
#         within a limited frame of 9am to 6pm.
# 
#         Fortunately the directionality of time limits our duration hours
#         to positive values. So theres that. And seconds: no seconds, or
#         nanoseconds, or timezones, as noted, but I can't figure out how
#         those would come into play anyway. Are we doing business on the
#         Concorde?
# 
#         I don't think we're going to worry about either lunchbreaks or
#         holidays either, and hold fast to the given input timestamp
#         format, without extensive validation or anything. Life is
#         complicated enough.

#         We're also going to make one more simplifting assumption, that
#         the timestamp input occurs with a business day. In a real program
#         we'd want to verify this, and start the clock at the next
#         business day, but if the ticket was submitted by the business
#         personnel then the bnusiness would need to be open, no? 
# 
#       Method:
# 
#         As the day of the week is a very important part of the problem,
#         and subject to arcane leap-year rules in February, I think it
#         prudent to armor ourselves under the protective shield of the
#         DateTime module so we can poll th eday of the week value directly
#         from there. We can't, however just add hours to find a new date,
#         as all hours are important but some hours are more important that
#         others.
# 
#         It seems a good strategy would be to break down the hours added
#         into 3 components:
# 
#             1. the hours remaining in the current day 
#             2. a series of 9-hour intervals comprising complete workdays 
#             3. a remaining portion of less than 9 hours to place the
#                endpoint timestamp
#         
#         We will start by parsing the input timestamp into a new DateTime
#         object and try deriving the three components from there. Which is
#         fine, but DateTime doesn't actually do that. We'll need something
#         else. 

#         And what would that be?
# 
#         As it work out, DateTime does not parse dates because there's way
#         too many varieties to choose from when writng them down. So
#         instead of trying to implement the functionality within the date
#         module directly, and entire class of classes takes the role
#         instead: DateTime::Format. This in turn is subclassed further
#         with a whatever scheme you might want to accomodate.
# 
#         We will pick DateTime::Format::Strptime which basically
#         implements the unix utilities strptime and strftime, allowing one
#         to specifiy a formatting template from a list of symbols,
#         including shortcuts for some of the more common layouts. 
        
#         Once the timestamp is in we can then create another DateTIme
#         object for the end of whatever day we are in, and subtract the
#         earlier from the later to create a duration until the end of the day. 
# 
#         If the end of the day is after the given span, we add the minutes
#         to the current day and report. If we need to jump to the next day
#         things get a little more complicated.
# 
#         We need to first reset by removing the reamining mnutes for the
#         current day from the count, ans start a new day object at 9am.
#         This will be initialized at the next business day, skipping hte
#         weekend if necessary. From there we subtract entire days in
#         minutes, 540 each, until the span is less than 540, again
#         skipping weekends if necessary. This locates the end date.

#         Once we have the end date we add the remaining minute count of
#         the duration to obtain the end time within the day.
# 
        
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use DateTime;
use DateTime::Format::Strptime ;


my ($timestamp, $delta) = @ARGV;
if (@ARGV == 0) { ($timestamp, $delta) =  ( '2022-08-01 10:30', 400 )}

## convert to minutes
my $duration_minutes = $delta * 60;

## parse input and create a DateTime object for the timestamp
my $format = DateTime::Format::Strptime->new(
                 pattern   => '%F %H:%M');            
my $date  = $format->parse_datetime($timestamp);

## calculate remaining minutes in current day
my $day_end =  DateTime->new(
    year       => $date->year,
    month      => $date->month,
    day        => $date->day,
    hour       => 18,
    minute     => 0
);
my $date_remaining_duration = $day_end->subtract_datetime($date);
my $remaining_minutes_today = $date_remaining_duration->hours * 60 +
                              $date_remaining_duration->minutes;

## CASE 1: duration falls within current day
##
if ($duration_minutes <= $remaining_minutes_today) {
    $date->add( minutes => $duration_minutes );
}

## CASE 2: we finish this day and locate the ending day
##
else {
    ## subtract remaining time within current day
    $duration_minutes -= $remaining_minutes_today;

    ## start a new day to the next business day
    $date->set_hour( 9 );
    $date->set_minute( 0 );
    $date->add( days => ($date->day_of_week == 5 ? 3 : 1));

    ## add any complete days, skipping weekends
    while ($duration_minutes > 540) {      ## 540 minutes in 9-hour day
        $date->add( days => ($date->day_of_week == 5 ? 3 : 1));
        $duration_minutes -= 540;
    }

    ## add any remaining minutes forward from 9am on the end day
    $date->add( minutes => $duration_minutes );
}

## output timestamp as per format
$date->set_formatter($format);
say $date->stringify;

