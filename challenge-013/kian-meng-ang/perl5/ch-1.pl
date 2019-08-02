#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use DateTime;

foreach my $month (1..12) {
    my $dt = DateTime->last_day_of_month(year => 2019, month => $month);
    while ($dt->day_of_week() != 5) {
        $dt->subtract(days => 1);
    }
    say $dt->ymd(q|/|);
}

1;

__END__
$ perl ch-1.pl
2019/01/25
2019/02/22
2019/03/29
2019/04/26
2019/05/31
2019/06/28
2019/07/26
2019/08/30
2019/09/27
2019/10/25
2019/11/29
2019/12/27
