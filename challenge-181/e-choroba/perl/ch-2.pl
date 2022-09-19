#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Time::Piece;
use Time::Seconds qw{ ONE_DAY };

sub hot_day ($fh) {
    my %temps;
    while (<$fh>) {
        my ($date, $temp) = split /, /;
        die "Duplicate temp for $date" if exists $temps{$date};

        $temps{$date} = $temp;
    }

    my @hot;
    my $next = "";
    my $temp;
    for my $date (sort keys %temps) {
        push @hot, $next
            if $date eq $next && $temp < $temps{$next};
        $temp = $temps{$date};
        $next = ('Time::Piece'->strptime($date, '%Y-%m-%d') + ONE_DAY)
            ->strftime('%Y-%m-%d');
    }
    return \@hot
}

use Test2::V0;
plan 1;

is hot_day(\*DATA), [qw[ 2022-08-02
                         2022-08-05
                         2022-08-06
                         2022-08-08
                         2022-08-10 ]];

__DATA__
2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25
