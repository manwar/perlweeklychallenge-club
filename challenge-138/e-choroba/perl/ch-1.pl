#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Time::Piece;
use Time::Seconds qw{ ONE_DAY };

sub workdays_slow {
    my ($year) = @_;
    my $d = 'Time::Piece'->strptime("$year-0101", '%Y-%m%d');
    my $count = 0;
    while ($d->year == $year) {
        my $wday = $d->wday;
        ++$count if $wday > 1 && $wday < 7;
        $d += ONE_DAY;
    }
    return $count
}

sub workdays_fast {
    my ($year) = @_;
    my $tp = 'Time::Piece'->strptime("$year-0101", '%Y-%m%d');
    my $wday = $tp->wday;
    my $leap = $tp->is_leap_year;

    return 260 if $wday == 7 || $wday == 1 && ! $leap;
    return 262 if $leap && $wday > 1 && $wday < 6;
    return 261
}

use Test2::V0;

is workdays_fast(2021), 261, 'Example 1';
is workdays_fast(2020), 262, 'Example 2';


for my $year (1900 .. 2100) {
    is workdays_slow($year), workdays_fast($year), "same $year";
}
done_testing();

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    slow => 'workdays_slow(1900 + int rand 1000)',
    fast => 'workdays_fast(1900 + int rand 1000)',
});
