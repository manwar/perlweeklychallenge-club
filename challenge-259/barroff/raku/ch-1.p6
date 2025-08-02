#!/usr/bin/env raku

use v6.d;

sub banking-day-offset(Date:D $start_date, Int:D $offset, @bank_holidays = [] --> Date) {
    return banking-day-offset($start_date.succ, $offset, @bank_holidays) if $start_date.day-of-week ∈ (6, 7);
    return banking-day-offset($start_date.succ, $offset, @bank_holidays) if $start_date ∈ @bank_holidays;
    return $start_date if $offset == 0;
    return banking-day-offset($start_date.succ, $offset - 1, @bank_holidays);
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is banking-day-offset(Date.new('2018-06-28'), 3, [Date.new('2018-07-03')]),
        Date.new('2018-07-04'), 'works for 2018-07-04';
    is banking-day-offset(Date.new('2018-06-28'), 3),
        Date.new('2018-07-03'), 'works for 2018-07-03';
}
