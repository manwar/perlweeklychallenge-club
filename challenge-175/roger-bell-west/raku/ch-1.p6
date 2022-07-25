#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(lastsunday(2022),
          [ '2022-01-30', '2022-02-27', '2022-03-27', '2022-04-24',
            '2022-05-29', '2022-06-26', '2022-07-31', '2022-08-28',
            '2022-09-25', '2022-10-30', '2022-11-27', '2022-12-25' ],
          'example 1');

sub lastsunday($year) {
    my @o;
    for 1..12 -> $month {
        my $dt = Date.new($year,$month,1).last-date-in-month();
        my $dl = $dt.day-of-week();
        if ($dl != 7) {
            $dt -= $dl;
        }
        @o.push($dt.Str());
    }
    return @o;
}
