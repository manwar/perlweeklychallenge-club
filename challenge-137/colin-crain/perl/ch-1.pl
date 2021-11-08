#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       137-1 Long Year
#         Submitted by: Mohammad S Anwar
#         Write a script to find all the years between 1900 and 2100 which is a Long Year.
# 
#         A year is Long if it has 53 weeks.
# 
#         Expected Output
#         1903, 1908, 1914, 1920, 1925,
#         1931, 1936, 1942, 1948, 1953,
#         1959, 1964, 1970, 1976, 1981,
#         1987, 1992, 1998, 2004, 2009,
#         2015, 2020, 2026, 2032, 2037,
#         2043, 2048, 2054, 2060, 2065,
#         2071, 2076, 2082, 2088, 2093,
#         2099
# 
#         a year, 365 days, divided into 7-day weeks yield 52 and 1/7 or
#         one extra day. IF it is  leap year, with 366 days, is will have
#         two. So by my reckoning, every year has 53 weeks worth of days:
#         52 plus a part or a week. So this challenge hinges on which day
#         of the week starts the year, and further, which day of the week
#         starts a given week. Two commonly accepted schemes are for a new
#         week to either start on Monday, running through Sunday, or for
#         the week to start on Sunday, running through the following
#         Saturday. That, I can see, is going to cause some
#         internationalization problems with our global community. So if we
#         start our weeks say on Sunday, then in a non-leap year where the
#         years starts on a Saturday we will roll into Sunday on December
#         31, and the year will have 53 weeks. For any other day the year
#         will only have 52 weeks. In the case of a leap year, however,
#         then the rollover will occur with two start days, either Friday
#         or Saturday. 
# 
#         In light of this sketchiness, the ISO has set up a standard that
#         the first week of the year is to be considered the week that
#         contains January 4, which is to say the first week containing at
#         least 4 days, or put another way the first week where the
#         majority of days falls within the new year. In this scheme
#         everything is shifted a few days, but the same precessional logic
#         applies.
# 
#         We could solve this mathematically, by determining the start day
#         of January 1, 1900, and precessing the day one or two days
#         depending on the arcane rules for placing leap years, noting when
#         the start dates properly align.
# 
#         But then again, that's why we have computers, to do this dreary,
#         repetitive work for us. Enter Dave Rolsky, and his DataTime module.
# 
#         What we can do, then, is choose the 28th of December in a given 
#         year, and check its week number. If that value is 53, then the week has
#         53 ISO weeks. Easy peasy.
# 
#         As this result matches the expected output, we will suppose that
#         interpretation of weeks in a year was what was being requested.
#         
# 
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
use DateTime::Duration;

my @years;

my $dt  = DateTime->new (    
                year    => 1900 ,
                month   => 12  ,
                day     => 28   ) ;

my $dur = DateTime::Duration->new (
                years   => 1    );

for (1..200) {
    if ($dt->week_number == 53) {
        push @years, $dt->year;
    }
    $dt->add( $dur );
}

## output phase
local $" = ', ';
my @five;
for (@years) {
    push @five, $_;
    if (scalar @five == 5) {
        say "@five";
        @five = ();
    }
}
say "@five";

