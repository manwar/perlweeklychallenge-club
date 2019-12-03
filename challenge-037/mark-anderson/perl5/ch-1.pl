#!/usr/bin/env perl

use Modern::Perl '2018';
use Time::Moment;

my $tm = Time::Moment->new(
    year  => 2019,
    month => 1
);

while($tm->year == 2019) {
    my $count = 0;
    my $month = $tm->strftime('%b');

    while($tm->strftime('%b') eq $month) {
        if($tm->day_of_week < 6) {
            $count++;
        }

        $tm = $tm->plus_days(1);
    }

    say "$month:$count days"; 
}
