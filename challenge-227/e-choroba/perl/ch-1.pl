#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# We can't use Time::Piece, it can't handle years before 1900.
use POSIX qw{ strftime };

use constant YEAR_START => 1900;


{   my %FRIDAY_13TH;
    my $year = 2000;
    while (14 != keys %FRIDAY_13TH && $year <= 2100) {
        $FRIDAY_13TH{ _weekday_and_leap($year) } //= _count_fridays($year);
    } continue {
        ++$year;
    }

    sub friday_13th($year) {
        return $FRIDAY_13TH{ _weekday_and_leap($year) }
    }
}


sub _count_fridays($year) {
    $year -= YEAR_START;
    my $count = 0;
    for my $month (0 .. 11) {
        # If a month starts on a Sunday, it has Friday the 13th.
        ++$count if 0 == strftime('%w', 0, 0, 0, 1, $month, $year);
    }
    return $count
}

sub _weekday_and_leap($year) {
    $year -= YEAR_START;
    my $wd = strftime('%w', 0, 0, 0, 0, 0, $year);
    my $is_leap = '29' eq strftime('%d', 0, 0, 0, 0, 2, $year) ? 1 : 0;
    return "$is_leap$wd"
}


use Test::More tests => 1 + 12;

is friday_13th(2023), 2, 'Example';
is friday_13th(1753), 2, 'First year';
is friday_13th(9999), 1, 'Last year';
is friday_13th(2015), 3, 'Wikipedia: Three';
is friday_13th($_), 2, "Wikipedia: Two $_" for 2017 .. 2020, 2023, 2024;
is friday_13th($_), 1, "Wikipedia: One $_" for 2016, 2021, 2022;
