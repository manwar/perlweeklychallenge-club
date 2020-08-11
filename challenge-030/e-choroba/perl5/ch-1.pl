#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Time::Piece;

sub sunday_xmas {
    my ($year) = @_;
    return 0 == 'Time::Piece'
        ->strptime("$year-12-25", '%Y-%m-%d')
        ->day_of_week
}

# use Test::More tests => 7;
# ok   sunday_xmas(2022), '25 Dec 2022';
# ok ! sunday_xmas(2021), '26 Dec 2021';
# ok ! sunday_xmas(2020), '27 Dec 2020';
# ok ! sunday_xmas(2025), '28 Dec 2025';
# ok ! sunday_xmas(2019), '29 Dec 2019';
# ok ! sunday_xmas(2029), '30 Dec 2029';
# ok ! sunday_xmas(2023), '31 Dec 2023';

for my $year (2019 .. 2100) {
    say "25 Dec $year" if sunday_xmas($year);
}
