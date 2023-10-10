sub task1 ( $year, $month, $weekday_of_month, $day_of_week --> UInt ) {

    my Date $day_1 .= new: :$year, :$month;

    my Date $first_dow = $day_1
                       + ($day_of_week - $day_1.day-of-week) mod 7;

    my Date $nth_dow = $first_dow
                     + ($weekday_of_month - 1) * 7;

    return $nth_dow.month == $month
        ?? $nth_dow.day
        !! 0;
}


my @tests =
    ( 16, (2024,  4, 3, 2) ),
    (  9, (2025, 10, 2, 4) ),
    (  0, (2026,  8, 5, 3) ),

    (  2, (2023, 10, 1, 1) ), # To spot `abs` vs `mod` issue.
    ( 31, (2023, 10, 5, 2) ),
;
use Test; plan @tests + 1;
for @tests -> ( $expected, @in ) {
    is task1(|@in), $expected, @in;
}
{
    my @tests_big = map { .day, (.year, .month, .weekday-of-month, .day-of-week) },
                    Date.new(:2023year) ..^ Date.new(:2033year);

    my $good = +grep { task1(|.[1]) == .[0] }, @tests_big;
    is $good, +@tests_big, "All {@tests_big.elems} are correct";
}
