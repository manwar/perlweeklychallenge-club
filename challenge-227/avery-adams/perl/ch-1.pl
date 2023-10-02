#!/usr/bin/perl

use v5.36;
use DateTime;

my $year = shift;
my $fridays;

foreach (1..12) {
    my $dt = DateTime->new('year' => $year, 'month' => $_, 'day' => 13);
    $fridays++ if $dt->day_of_week == 5;
}
say $fridays;
