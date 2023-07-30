enum DayNames «:Monday(1) Tuesday Wednesday Thursday Friday Saturday Sunday»;

sub task1 ( UInt $year where 1753..9999 --> UInt ) {
    return +grep { Date.new($year, $_, 13).day-of-week == Friday }, 1..12;
}


constant @tests =
    ( 1753, 2 ),
    ( 2023, 2 ),
    ( 9999, 1 ),
;
use Test;
plan @tests + 1;
for @tests -> ( UInt $in, UInt $expected ) {
    is task1($in), $expected;
}
ok all map { .&task1_alternate == .&task1 }, 1753..9999;


# By observing that the final answer completely depends on the
# day-of-week of the first day of the year, and whether it is a leap year,
# we could precompute then replace 12 .day-of-week calls
# with 1 .day-of-week and 1 .is-leap-year .
# However, I feel this takes the resulting code
# too far from the task description.
sub task1_alternate ( UInt $year --> UInt ) {
    constant @t = Nil, (2, 2), (2, 1), (1, 2), (3, 2), (1, 1), (1, 1), (2, 3);
    return @t[ .day-of-week ][ .is-leap-year ] given Date.new(:$year);
}
