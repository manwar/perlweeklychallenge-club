#!/usr/bin/perl
use warnings;
use strict;

use Time::Piece;
use Time::Seconds;

sub last_fridays {
    my ($year) = @_;
    my @fridays = map _last_friday($year, $_), 2 .. 12;
    push @fridays, _last_friday($year + 1, 1);
    return @fridays
}

sub _last_friday {
    my ($year, $month) = @_;
    my $date = 'Time::Piece'->strptime("$year/$month/1", '%Y/%m/%d');
    my $diff = ($date->wday + 1) % 7 || 7;
    $date = $date - $diff * ONE_DAY;
    return $date->strftime('%Y/%m/%d');
}

use Test::More tests => 1;

my @list = last_fridays(2019);
warn "@list";
chomp( my @expected = <DATA> );

is_deeply \@list, \@expected;

__DATA__
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
