#!/usr/bin/env perl

use 5.12.0;
use DateTime;
use Test::More;
use Test::Exception;

# Key is the 1st January day of week name for given year.
# Value index 0 for normal year and index 1 for leap year.
my %friday_13ths = (
    "Sunday"    => [ 2, 2 ],
    "Monday"    => [ 2, 2 ],
    "Tuesday"   => [ 2, 1 ],
    "Wednesday" => [ 1, 2 ],
    "Thursday"  => [ 3, 2 ],
    "Friday"    => [ 1, 1 ],
    "Saturday"  => [ 1, 1 ],
);

cmp_ok( unlucky_days(1753), "==", 2, "Test 1753 is 2" );
cmp_ok( unlucky_days(1970), "==", 3, "Test 1970 is 3" );
cmp_ok( unlucky_days(2023), "==", 2, "Test 2023 is 2" );
cmp_ok( unlucky_days(9999), "==", 1, "Test 9999 is 1" );
dies_ok { unlucky_days(1752) } "Test 1752 dies_ok";
done_testing();

sub unlucky_days {
    my $year = shift;
    if ( $year < 1753 || $year > 9999 ) {
        die "Year not in range: $year";
    }
    my $dt = DateTime->new(
        year  => $year,
        month => 1,
        day   => 1,
    );
    my $first_day_of_year = $dt->day_name();
    my $is_leap_year      = $dt->is_leap_year();
    return $friday_13ths{$first_day_of_year}[$is_leap_year];
}
