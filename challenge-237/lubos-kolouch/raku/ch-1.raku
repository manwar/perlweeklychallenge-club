use Test;

# Function to find the nth occurrence of a day in a given month and year
sub find-day(Int $year, Int $month, Int $weekday-of-month, Int $day-of-week --> Int) {
    # Find the first day of the month
    my $first-day = Date.new($year, $month, 1);

    # Calculate the difference between the first day of the month and the desired day of the week
    my $days-diff = ($day-of-week - $first-day.day-of-week) % 7;

    # Find the first occurrence of the desired day
    my $first-occurrence = $first-day.later(days => $days-diff);

    # Find the nth occurrence
    my $nth-occurrence = $first-occurrence.later(days => ($weekday-of-month - 1) * 7);

    # Check if the resulting date is in the same month
    return $nth-occurrence.month == $month ?? $nth-occurrence.day !! 0;
}

# Tests
plan 3;
is find-day(2024, 4, 3, 2), 16, 'Test Case 1';
is find-day(2025, 10, 2, 4), 9, 'Test Case 2';
is find-day(2026, 8, 5, 3), 0, 'Test Case 3';

