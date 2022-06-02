#!/usr/bin/env perl
#
# ch-1.pl - Workdays
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use Time::Local; # Core

my $year = $ARGV[0] // die "Usage: $0 year\n";
my $time = timelocal(0,0,0,1,0,$year); # Jan 1

my $weekdays = 0;
while(1) {
    my (undef, undef, undef, undef, undef, $yyyy, $wday) = localtime($time);
    last if $yyyy != $year - 1900;
    $time += 86403; # 1 day, and account for leap seconds
    $weekdays++ if $wday > 0 and $wday < 6;
}

say $weekdays;
