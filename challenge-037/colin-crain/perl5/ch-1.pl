#! /opt/local/bin/perl
#
#       workdays.pl
#
#       PWC37 - Task #1
#           Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.
#               Jan: 23 days
#               Feb: 20 days
#               Mar: 21 days
#               Apr: 22 days
#               May: 23 days
#               Jun: 20 days
#               Jul: 23 days
#               Aug: 22 days
#               Sep: 21 days
#               Oct: 23 days
#               Nov: 21 days
#               Dec: 22 days
#
#       method: we could create a complex configuration of month names,
#           lengths, the day of the week of jan 1 and keep a running offset
#           to directly count the days Monday through Friday as we progress
#           through the year. That's all quite doable, albeit perhaps a bit
#           mundane. Rather, as this is essentially a date problem, it would
#           be more fruitful to look to my preferred date package,
#           Date::Manip, to see what it can do.
#
#           Date::Manip is a giant package of packages that does pretty much
#           anything having to do with dates, so it is no surprise it can
#           address this problem. It is, however, a little bit surprising how well it
#           dispatches the fundamental complexity. Essentially we can simply reframe
#           the question in terms of "make a list of every day of the year
#           that's a weekday" and then parse out that list by month number,
#           incrementing a hash. For output we do a quick substitution of the
#           month name for its number and we're done.
#
#           To do this magic we can create an object representing a date
#           recurrence, in this case the next day, giving us a list of all days
#           within two boundaries. Because a fairly common date calculation
#           involves, for instance, "7 to 10 business days", the idea of
#           business days, or workdays, can be incorporated directly into the
#           frequency definition string for the recurrence object, changing
#           "every day" into "every day that is In Business Days (IBD)" with a
#           simple modifier. Once established this object can be asked to
#           generate a list of date objects, one for each day. Extracting just
#           the month from that object gives us a hash key to increment. Because
#           the $date->values() method can return either a list or scalar
#           context, we need to wrap the result in parens; we force a list and
#           extract just the second, month, element.
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

use Date::Manip;

my $recur   = new Date::Manip::Recur;
$recur->parse("0:0:0:1*0:0:0*IBD","Jan 1  2019","Jan 1  2019","Dec 31 2019");
my @date    = $recur->dates();

## tally the data by month
my %tally;
for ( @date ){
    $tally{ ($_->value)[1] }++              ## force list context for value() method
}

## ...and convert the month indexes to names and output the totals
my @month_names   = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
for (sort {$a <=> $b} keys %tally) {
    say "$month_names[$_-1]: $tally{$_} days";
}
