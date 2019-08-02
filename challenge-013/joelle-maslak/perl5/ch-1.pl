#!/usr/bin/env perl

use strict;
use warnings;

use v5.22;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use POSIX qw(mktime strftime);

die("Must provide year") if @ARGV != 1;
my $year = +$ARGV[0];

my $days = get_all_days($year);
say join "\n",
    map  { strftime("%Y-%m-%d", gmtime($_)) }
    grep { last_friday($_) }
    @$days;

sub last_friday($dt) {
    if ((gmtime($dt))[6] == 5) {    # Is day Friday?
        # Is this the LAST friday?  Add a week to it and see if the
        # month changes
        if ((gmtime($dt+(86400*7)))[4] != (gmtime($dt))[4]) {
            return 1;
        }
    }
    return;
}

sub get_all_days($year) {
    my @ret;
    my $day = mktime(0,0,12,1,0,$year-1900);
    while ((gmtime($day))[5] == $year-1900) {
        push @ret, $day;
        $day += 86400; # Number of seconds in a day
    }

    return \@ret;
}

