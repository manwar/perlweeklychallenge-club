use strict;
use warnings;
use Test::More;
use Time::Local;

# Function to find the nth occurrence of a day in a given month and year
sub find_day {
    my ($year, $month, $weekday_of_month, $day_of_week) = @_;

    # Calculate the timestamp for the first day of the month
    my $first_day = timelocal(0, 0, 0, 1, $month - 1, $year);

    # Calculate the day of the week for the first day of the month (0 = Sunday, 1 = Monday, ...)
    my $first_day_of_week = (localtime($first_day))[6];

    # Calculate the difference in days to reach the desired day of the week
    my $days_diff = ($day_of_week - $first_day_of_week) % 7;

    # Calculate the timestamp for the first occurrence of the desired day
    my $first_occurrence = $first_day + ($days_diff * 86400);

    # Calculate the timestamp for the nth occurrence
    my $nth_occurrence = $first_occurrence + (($weekday_of_month - 1) * 7 * 86400);

    # Check if the resulting date is still in the same month
    return ((localtime($nth_occurrence))[4] == $month - 1) ? (localtime($nth_occurrence))[3] : 0;
}

# Tests
is(find_day(2024, 4, 3, 2), 16, 'Test Case 1');
is(find_day(2025, 10, 2, 4), 9, 'Test Case 2');
is(find_day(2026, 8, 5, 3), 0, 'Test Case 3');

done_testing();

