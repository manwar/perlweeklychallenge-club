#!/usr/bin/env perl

# Task 1: Shortest Time
# Submitted by: Mohammad S Anwar
# 
# You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
# Write a script to find out the shortest time in minutes between any two time points.
#
# Example 1
# Input: @time = ("00:00", "23:55", "20:00")
# Output: 5
# 
# Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
# 
# Example 2
# Input: @array = ("01:01", "00:50", "00:57")
# Output: 4
# 
# Example 3
# Input: @array = ("10:10", "09:30", "09:00", "09:55")
# Output: 15

use strict;
use warnings;
use Math::Combinatorics;

my @input = @ARGV;
die "Input error\n"
    if scalar @input < 2
       or
       (scalar map { $_ =~ /^\d{2}:\d{2}$/ ? () : 1 }
                @input) != 0
       or
       (scalar map { $_ le '24:00' ? () : 1 }
                @input) != 0;

my @minutes = map { get_minutes($_) } @input;

my $combinat = Math::Combinatorics->new(count => 2,
                                        data => [0..$#minutes],
                                       );
my %min;
while (my @pair = $combinat->next_combination) {
    my $diff_minutes = diff_minutes($minutes[$pair[0]], $minutes[$pair[1]]);
    if (!defined($min{val})
        or
        $min{val} > $diff_minutes
    ) {
        $min{val} = $diff_minutes;
        $min{pair} = \@pair;
    }
}

print $min{val};
printf "\nSince the difference between \"%s\" and \"%s\" is the shortest (%d minutes).\n", $input[ $min{pair}[0] ], $input[ $min{pair}[1] ], $min{val};

exit 0;

sub get_minutes {
    my $time = shift;

    return 60 * (substr $time, 0, 2) +
                (substr $time, 3, 2);
}

sub diff_minutes {
    my ($m1, $m2) = @_;

    my $diff_minutes = abs($m1-$m2);
    
    return ($diff_minutes >= 720)        # 12h * 60 = minutes
        ? (1440 - $diff_minutes)         # 24h * 60 = minutes
        : $diff_minutes;
}
