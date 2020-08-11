#!/usr/env perl
# weekdays in month
# Challenge 1 week 37

use strict;
use warnings;
use DateTime;
 
my $dt = DateTime->new(            # start at first day of the year
    year       => 2019,
    month      => 1,
    day        => 1,);
    
my %counters;                      # set up weekday counters

while ($dt->year() ==2019){        # Until the year is over
  $counters{$dt->month()}+=1       # add to each month's counter
     if ($dt->day_of_week() <6);   # if the day is a week day. 
  $dt->add( days => 1 )            # Get next day
}

print "Answer to 1st Challenge of week 37\nIn 2019\n";
for (1..12){                       # now print out each month
   print qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/[$_-1].
         " has " .$counters{$_} . " Weekdays \n"; # and its weeday counts
}

#Output
#Answer to 1st Challenge of week 37
#In 2019
#Jan has 23 Weekdays 
#Feb has 20 Weekdays 
#Mar has 21 Weekdays 
#Apr has 22 Weekdays 
#May has 23 Weekdays 
#Jun has 20 Weekdays 
#Jul has 23 Weekdays 
#Aug has 22 Weekdays 
#Sep has 21 Weekdays 
#Oct has 23 Weekdays 
#Nov has 21 Weekdays 
#Dec has 22 Weekdays 


