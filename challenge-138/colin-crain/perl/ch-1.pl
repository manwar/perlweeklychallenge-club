#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#
#       Workdays
#         Submitted by: Mohammad S Anwar
#         You are given a year, $year in 4-digits form.
# 
#         Write a script to calculate the total number of workdays in the given year.
# 
#         For the task, we consider, Monday - Friday as workdays.
# 
#         Example 1
#         Input: $year = 2021
#         Output: 261
#         Example 2
#         Input: $year = 2020
#         Output: 262

#         method:
# 
#             Ahh, another DateTime problem, as far as I'm concerned.
#             Excellent. This is good for me, actually, as I could use more
#             immediate familiiarity with that module. I did previusly use
#             Date::Manip on a project, but I think I'm going to move on
#             over on this one. Let's take 'er out for a spin, as they say.
# 
#             The way we'll do this is to count them. We have January 1st,
#             and a set duration of one day. We assess a day, chalk it up
#             if its a workday, count down the days remaining to be
#             counted, and move to the next day.
# 
#             Some people would solve this by determining whether its a
#             leap year and responding 261 or 262 appropriately, but I
#             consider this unsporting. I will pretend I don't know the
#             answer and recalculate it.
# 
#             I think it's the scientist thing. There's no shame in
#             repeating an experiment. I suppose I am relying on DateTime
#             to give me the correct days of the week, but recreating that
#             calculation breaks the covenant to not mess with doing your
#             own calender calculations. The calender we use is a twisted
#             artifact wedged and shimmed into fitting just right,
#             requiring constant maintenance to properly reflect the
#             physical world we live in. Leap years are child's play, a
#             hack from centuries ago. Leap century years are geeting
#             there, but leap seconds are where its at, baby, and don't you
#             forget. We must properly account for Earth's perturbations on
#             its axis. I do pity the poor spacecraft designers, who need
#             to toss reletivity into the mix. I don't know how they do it.
# 
#             Seriously, I don't know how they do it. Probably a lot of
#             little post-corrections whenever things get out of line. But
#             that's just a guess. Try and avoid making it matter and fix
#             it in editing. 
# 
#             In any case we're going to play around with durations a bit
#             and count the days. Come on, it'll be fun.
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use DateTime;

my $year = shift @ARGV || 2020;

my $dt  = DateTime
            ->new(  year    => $year    ,
                    month   => 1        ,
                    day     => 1        );

my $dur = DateTime::Duration
            ->new ( days    => 1        );

my $num_days = 365;
$dt->is_leap_year && $num_days++;
my $workdays;


while ( $num_days-- ) {
    $dt->dow < 6 && $workdays++;
    $dt->add( $dur );
}

say $workdays;


