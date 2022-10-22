#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       days-together-and-apart.pl
#
#       Days Together
#         Submitted by: Mohammad S Anwar
#         Two friends, Foo and Bar gone on holidays seperately to the same
#         city. You are given their schedule i.e. start date and end date.
# 
#         To keep the task simple, the date is in the form DD-MM and all
#         dates belong to the same calendar year i.e. between 01-01 and
#         31-12. Also the year is non-leap year and both dates are
#         inclusive.
# 
#         Write a script to find out for the given schedule, how many days
#         they spent together in the city, if at all.
# 
#         Example 1
#             Input: Foo => SD: '12-01' ED: '20-01'
#                    Bar => SD: '15-01' ED: '18-01'   
#             Output: 4 days
# 
#         Example 2
#             Input: Foo => SD: '02-03' ED: '12-03'
#                    Bar => SD: '13-03' ED: '14-03'    
#             Output: 0 day
# 
#         Example 3
#             Input: Foo => SD: '02-03' ED: '12-03'
#                    Bar => SD: '11-03' ED: '15-03'   
#             Output: 2 days
# 
#         Example 4
#             Input: Foo => SD: '30-03' ED: '05-04'
#                    Bar => SD: '28-03' ED: '02-04'     
#             Output: 4 days

#       analysis
# 
#         Date and time manipulation code is notorously tricky, but with
#         the added constraints given this task becomes quite managable.
#         The devil, as they say, is in the details, and in the case of
#         date and time manipulations that would mean the myriad edge and
#         corner cases such as the occurrences of leap years, crossing year
#         boundarys or the sudden interjection of daylight savings time or
#         bank holidays.
# 
#         The first couple of examples I listed are relevant to the task at
#         hand and are excluded as special cases, allowing us to simplify
#         the problem as finding the intersection of two intervals.
# 
#       method
# 
#         month durations in days are fixed (in this simplification) yet
#         the pattern is irregular. We could use a lookup of months to
#         durations to directly count the days within each interval: the
#         end of the current month, the sum of any iterstitial months plus
#         the days of the end month. This would work but sounds tedious,
#         frankly.
# 
#         ALternatly we could use the same months to days lookup to
#         initially normalize the data in terms of days from the get-go,
#         and proceed from there with some strightforward arithmetic. In
#         this way we remove months from further calculations immedaitely.
#         This is consistent with our desired result, which will be a count
#         of days only, up to a theroretical 365 of them. 
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


sub days_together ( $sd1, $ed1, $sd2, $ed2 ) {

    ## convert day-month strings into day of year values
    ($sd1, $ed1, $sd2, $ed2) =  map { day_of_year( $_->@* )}
                                map { [ m/(\d\d)-(\d\d)/ ] } 
                                ($sd1, $ed1, $sd2, $ed2);
    
    ## inclusive span between last start and first end
    my $days =  ($ed1 > $ed2 ? $ed2 : $ed1 ) - 
                ($sd1 > $sd2 ? $sd1 : $sd2 ) + 1;
                
    return $days > 0 ? $days : 0;
    
}   

sub day_of_year ( $d, $m ) {
## both months and days 1-indexed, no leap year calculations 

    state @mdays = ( 31, 28, 31, 30, 31, 30, 31, 30, 31, 31, 30, 31 );

    my $days = $d;                      ## current month days
    $days += $mdays[$m-1] while --$m;   ## previous whole-month days
    
    return $days;
}






use Test::More;

is day_of_year( 31, 1 ), 31, 'jan-31';
is day_of_year( 20, 2 ), 51, 'feb-20';
is day_of_year( 10, 3 ), 69, 'mar-10';

is days_together( qw( 12-01 20-01 15-01 18-01 ) ),   4, 'ex-1';
is days_together( qw( 02-03 12-03 13-03 14-03 ) ),   0, 'ex-2';
is days_together( qw( 02-03 12-03 11-03 15-03 ) ),   2, 'ex-3';
is days_together( qw( 30-03 05-04 28-03 02-04 ) ),   4, 'ex-4';
is days_together( qw( 30-03 05-04 28-06 02-07 ) ),   0, 'missing completely';
is days_together( qw( 30-03 30-03 30-03 30-03 ) ),   1, 'same day';
is days_together( qw( 30-03 30-03 22-03 22-05 ) ),   1, 'one day vacay first friend';
is days_together( qw( 22-03 22-05 30-03 30-03 ) ),   1, 'one day vacay second friend';


done_testing();
