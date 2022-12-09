#!/usr/bin/perl
# ch-1.pl
#
# You are given time in the format hh:mm with one missing digit.
# Write a script to find the highest digit between 0-9 that makes it valid time.

use warnings;
use strict;
use Data::Dumper;

my @times = (
    '?5:00',
    '?3:00',
    '1?:00',
    '2?:00',
    '12:?5',
    '12:5?'
);

foreach my $time (@times) {
    my ($output, $newtime) = calculate($time);
    print "$time -> $output ($newtime)\n";
}

sub calculate {
    my $time = shift;
    if ($time =~ m/^\?([0-3]:\d\d)$/) { # 20:XX - 23:XX
        return (2, "2$1");
    } elsif ($time =~ m/^\?(\d:\d\d)$/) { # 14:XX - 19:XX
        return (1, "1$1");
    } elsif ($time =~ m/^2\?(:\d\d)$/) { # 23:XX
        return (3, "23$1");
    } elsif ($time =~ m/^([01])\?(:\d\d)$/) { # 09:XX or 19:XX
        return (9, "${1}9$2");
    } elsif ($time =~ m/^(\d\d:)\?(\d)$/) { # XX:5X
        return (5, "${1}5$2");
    } elsif ($time =~ m/^(\d\d:\d)\?$/) { # XX:X9
        return (9, "${1}9");
    } else {
        die "Invalid time $time!\n";
    }
}

