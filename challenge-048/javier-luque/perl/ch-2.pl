#!/usr/bin/perl
# test: perl ch-2.pl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;
use feature qw /say/;

my $current_date = Time::Piece->strptime('01-01-2000', '%m-%d-%Y');
my $end_date     = Time::Piece->strptime('12-31-2999', '%m-%d-%Y');

while ($current_date < $end_date) {
    my $date_string = $current_date->strftime('%m%d%Y');
    say $date_string if ($date_string eq reverse($date_string));
    $current_date = $current_date + ONE_DAY;
}

