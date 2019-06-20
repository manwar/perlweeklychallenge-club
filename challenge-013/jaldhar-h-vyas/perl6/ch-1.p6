#!/usr/bin/perl6

sub elapsedLeapDays(Int $year) {
    my $yr = $year - 1752; # We want 1-based years here.
    return $yr div 4 - $yr div 100 + $yr div 400;
}

sub isLeap(Int $year) {
    # years divisible by 100 are not leap years unless they are divisble by 400.
    return ($year %% 4 && (!$year %% 100 || $year %% 400));
}

# BUG: Is only accurate for years per the Gregorian calendar.  Great Britain
#      and her colonies adopted the Gregorian calendar in September 1752.  Other
#      locales did so at different dates but this script does not take any of 
#      that into account and just restricts input to 1753 onwards.
#
multi sub MAIN(
    Int $year where { $_ > 1752 } #= A four digit year greater than 1752
) {

    my $elapsedDays = ($year - 1753) * 365 + elapsedLeapDays($year);
    my $newYearDay = ($elapsedDays + 1) % 7; # +1 because 1753/1/1 was a Monday.

    my @lastDays = (30, 58, 89, 119, 150, 180, 211, 242, 272, 303, 333, 364);
    # account for Feb 29 in leap years.
    if isLeap($year) {
        for 1 .. 11 -> $month {
            @lastDays[$month]++;
        }
    }
    my @offset = (2, 3, 4, 5, 6, 0, 1);

    for 0 .. 11 -> $month {
        my $lastDay = @lastDays[$month];
        my $lastFriday = $lastDay - @offset[($newYearDay + $lastDay) % 7];

        my $day = $lastFriday - (($month > 0) ?? @lastDays[$month - 1] !! -1);
        ($year, $month + 1, $day).join('/').say;
    }
}
