#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use POSIX qw(mktime strftime);

my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );

my (@days) = map { get_all_days($_)->@* } 1900..2019;
say join "\n",
    map  { $months[(gmtime($_))[4]] . " " . strftime("%Y", gmtime($_)) }
    grep { (gmtime($_))[6] == 0 and (gmtime($_))[3] == 31 }
    @days;

sub get_all_days($year) {
    my @ret;
    my $day = mktime(0,0,12,1,0,$year-1900);
    while ((gmtime($day))[5] == $year-1900) {
        push @ret, $day;
        $day += 86400; # Number of seconds in a day
    }

    return \@ret;
}

