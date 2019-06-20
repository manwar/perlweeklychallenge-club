#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub usage() {
print<<"-USAGE-";
Usage:
  $0 <year>
  
    <year>    A four digit year greater than 1752
-USAGE-
    exit(0);
}

sub elapsedLeapDays {
    my ($year) = @_;

    $year -= 1752; # We want 1-based years here.
    return int($year / 4) - int($year / 100) + int($year / 400);
}

sub isLeap {
    my ($year) = @_;

    # years divisible by 100 are not leap years unless they are divisble by 400.
    return ($year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0));
}

my $year = shift // usage();

# BUG: Is only accurate for years per the Gregorian calendar.  Great Britain
#      and her colonies adopted the Gregorian calendar in September 1752.  Other
#      locales did so at different dates but this script does not take any of 
#      that into account and just restricts input to 1753 onwards.
#
if ($year < 1753) {
    usage;
}

my $elapsedDays = ($year - 1753) * 365 + elapsedLeapDays($year);
my $newYearDay = ($elapsedDays + 1) % 7; # +1 because 1753/1/1 was a Monday.

my @lastDays = (30, 58, 89, 119, 150, 180, 211, 242, 272, 303, 333, 364);
# account for Feb 29 in leap years.
if (isLeap($year)) {
    for my $month (1 .. 11) {
        $lastDays[$month]++;
    }
}
my @offset = (2, 3, 4, 5, 6, 0, 1);

 for my $month (0 .. 11) {
    my $lastDay = $lastDays[$month];
    my $lastFriday = $lastDay - $offset[($newYearDay + $lastDay) % 7];

    my $day = $lastFriday - (($month > 0) ? $lastDays[$month - 1] : -1);
    say join q{/}, ($year, $month + 1, $day);
}
