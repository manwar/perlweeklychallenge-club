#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       i-know-what-you-did-last-sunday.pl
#
#       Last Sunday
#         Submitted by: Mohammad S Anwar
#         Write a script to list Last Sunday of every month in the given year.
# 
#         For example, for year 2022, we should get the following:
# 
# 
#         2022-01-30
#         2022-02-27
#         2022-03-27
#         2022-04-24
#         2022-05-29
#         2022-06-26
#         2022-07-31
#         2022-08-28
#         2022-09-25
#         2022-10-30
#         2022-11-27
#         2022-12-25

#       method:
# 
#         We're wise enough to know when to haul in a library to do our
#         dity work, and in the case of date and time manipulations now is
#         that time. In the long run, it just doesn't pay not to. With leap
#         years and whatnot, tracking daya of the week is a fool's erand.
#         Doable, but subject to too many pitfalls to make making certain
#         you didn't miss every single one a worthwhile pursuit. After all,
#         someone has gone through an enormous amount of trouble to figure
#         out the hoary details already, why not honor their efforts?
# 
#         Two methods come to mind: 1. Once for every month in the year,
#         check the day of the week for the last day and count backwards
#         from there until we find a Sunday 2. Look at every day starting
#         on January 1, note the month and date if it is a Sunday, preserce
#         the previously saved month and day of the month changes or we run
#         out of days.
# 
#         Each has their advantages I suppose. I think I'll try the first
#         becausse I haven't done that before.
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

use DateTime ;


my $year = shift @ARGV // 2022;

for my $month ( 1..12 ) {
    my $dt = DateTime->last_day_of_month( year => $year, month => $month );
    $dt->subtract( days => 1 ) until $dt->day_of_week == 7;
    say $dt->format_cldr( "MMM dd, YYYY" );
}



