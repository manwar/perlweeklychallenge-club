#!/usr/bin/env raku

=begin pod

Week 187:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-187

Task #1: Days Together

    Two friends, Foo and Bar gone on holidays seperately to the same
    city. You are given their schedule i.e. start date and end date.

    To keep the task simple, the date is in the form 'DD-MM' and all
    dates belong to the  same calendar year i.e. between '01-01' and
    '31-12'.

    Also the year is non-leap year and both dates are inclusive.

=end pod

use Test;

is days-together('12-01','20-01','15-01','18-01'), 4, 'Example 1';
is days-together('02-03','12-03','13-03','14-03'), 0, 'Example 2';
is days-together('02-03','12-03','11-03','15-03'), 2, 'Example 3';
is days-together('30-03','05-04','28-03','02-04'), 4, 'Example 4';

done-testing;

#
#
# METHODS

sub days-together(Str $sd1, Str $ed1, Str $sd2, Str $ed2 --> Int) {
    my Date $_sd1 = _date($sd1);
    my Date $_ed1 = _date($ed1);
    my Date $_sd2 = _date($sd2);
    my Date $_ed2 = _date($ed2);

    my Int $days = 0;

    return $days if $_ed1 < $_sd2;

    if $_ed1 <= $_sd2 {
        $days = _days_together($_ed1, $_ed2);
    }
    elsif $_sd2 <= $_sd1 {
        $days = _days_together($_sd1, $_ed1, $_ed2);
    }
    elsif $_sd2 <= $_ed2 {
        $days = _days_together($_sd2, $_ed1, $_ed2);
    }

    return $days;
}

sub _date(Str $date --> Date) {
    my ($day, $month) = $date.split("-");
    return Date.new(
        year  => 2022,
        month => $month,
        day   => $day
    );
}

sub _days_together(Date $from, Date $to, Date $_to? --> Int) {
    my Date $end_date = $to;
    $end_date = $_to if (defined $_to) && ($to > $_to);
    return $end_date - $from + 1;
}
