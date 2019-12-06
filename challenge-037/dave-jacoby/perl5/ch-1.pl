#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use DateTime;

my $start = DateTime->new(
    year      => 2019,
    month     => 1,
    day       => 1,
    hour      => 12,
    minute    => 0,
    second    => 0,
    time_zone => 'floating',
);

my $day = DateTime::Duration->new( days => 1 );

my $list  = {};
my $names = {};

# in DateTime, Monday is 1 and Sunday is 7, so weekdays are 1-5,
# or < 6. 
while ( $start->year == 2019 ) {
    if ( $start->day_of_week < 6 ) { $list->{ $start->month }++ }
    $names->{ $start->month } //= $start->month_abbr;
    $start->add($day);
}

for my $m ( 1 .. 12 ) {
    my $month = $names->{$m};
    my $c     = $list->{$m};
    say qq{$month: $c days};
}
