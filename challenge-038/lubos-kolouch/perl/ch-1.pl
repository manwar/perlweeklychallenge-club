#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 6;

sub date_finder {
    my ($input) = @_;
    if ( length($input) != 7 ) {
        die "Input must be 7 digits long\n";
    }

    my ( $century_digit, $year_digits, $month_digits, $day_digits ) =
      unpack "A1A2A2A2", $input;

    my $century = $century_digit == 1 ? "20" : "19";
    my $year    = "$century$year_digits";

    if ( $month_digits < 1 || $month_digits > 12 ) {
        die "Invalid month\n";
    }

    my @days_in_month = ( 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );
    if ( $year % 4 == 0 && ( $year % 100 != 0 || $year % 400 == 0 ) ) {
        $days_in_month[2] = 29;
    }

    if ( $day_digits < 1 || $day_digits > $days_in_month[$month_digits] ) {
        die "Invalid day\n";
    }

    return sprintf "%04d-%02d-%02d", $year, $month_digits, $day_digits;
}

is( date_finder('2230120'), '1923-01-20', 'Test case: valid date' );
is( date_finder('2230230'), '1923-02-30', 'Test case: invalid day' );
is( date_finder('2230015'), '1923-00-15', 'Test case: invalid month' );
is( date_finder('1230229'), '2023-02-29', 'Test case: leap year' );
is( date_finder('1230228'), '2023-02-28', 'Test case: non-leap year' );
is( date_finder('1230429'), '2023-04-29', 'Test case: valid date' );
