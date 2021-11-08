#!/usr/bin/perl
use warnings;
use strict;

use Time::Piece;

# This should return localtime, but in order to verify the examples,
# we need to set today to Wednesday September the 22nd.
sub today {
    return 'Time::Piece'->strptime('2021/09/22', '%Y/%m/%d');
}

sub mirror_dates {
    my ($birthdate) = @_;
    my $birthday = 'Time::Piece'->strptime($birthdate, '%Y/%m/%d');
    my $today = today();
    my $age = $today - $birthday;
    return [map $_->ymd('/'),
                $birthday - $age,
                $today + $age]
}

use Test2::V0;
plan 3;

is mirror_dates('2021/09/18'),
    ['2021/09/14', '2021/09/26'],
    'Example 1';

is mirror_dates('1975/10/10'),
    ['1929/10/27', '2067/09/05'],
    'Example 2';

is mirror_dates('1967/02/14'),
    ['1912/07/08', '2076/04/30'],
    'Example 3';

