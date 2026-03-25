#!/usr/bin/perl
use strict;
use warnings;

# For this Challenge, I choose for combining C-style thinking with Perl-style
# expressiveness - and that’s a powerful mix.
#
# The C-style approach brings structure and clarity. By writing explicit cases
# with simple, top-down logic with its if-else blocks, code closely mirrors the
# problem: each condition is visible, understandable, and easy to verify.
# This makes debugging straightforward and builds confidence that all edge cases
# are handled. This style is reassuring because nothing feels “hidden” or magical.
#
# At the same time, I use Perl’s postfix if, which adds elegance and conciseness.
# Instead of wrapping everything in blocks, you can write clear one-liners like
# return 10 if ...;. This reduces visual clutter and keeps the focus on the logic
# itself. It’s a perfect example of Perl helping you say more with less - without
# sacrificing readability.
#
# Another point is the use of helper functions like count_hours and count_minutes.
# This separation keeps each piece small, focused, and easy to test. It also makes
# the main function (count_times) beautifully simple: it reads almost like plain English.

# Implementation

sub count_minutes {
    my ($M) = @_;

    return 1  if($M =~ /^[0-5][0-9]$/); # fully specified
    return 10 if($M =~ /^[0-5]\?$/); # d?
    return 6  if($M =~ /^\?[0-9]$/); # ?d
    return 60 if($M eq "??"); # ??
    return 0;
}

sub count_hours {
    my ($H) = @_;

    return 1  if($H =~ /^(?:[01][0-9]|2[0-3])$/); # fully specified
    return 24 if($H eq "??"); # ??
    return 10 if($H =~ /^[0-1]\?$/); # d?
    return 4  if($H =~ /^[2]\?$/); # d?
    return 2  if($H =~ /^\?[4-9]$/); # ?d
    return 3  if($H =~ /^\?[0-3]$/); # ?d
    return 0;
}

sub count_times {
    my ($time) = @_;
    # separate hours and minutes
    my ($H, $M) = split /:/, $time;

    return (count_hours($H) * count_minutes($M) );
}


# Tests

# Testcases Challenge 366

printf "%d\n", count_times('?2:34'); # 3
printf "%d\n", count_times('?4:?0'); # 12
printf "%d\n", count_times('??:??'); # 1440
printf "%d\n", count_times('?3:45'); # 3
printf "%d\n", count_times('2?:15'); # 4

# Testcases Niels van Dijke

printf "%d\n", count_times('00:00'); # 1
printf "%d\n", count_times('00:0?'); # 10
printf "%d\n", count_times('00:?0'); # 6
printf "%d\n", count_times('00:??'); # 6 * 10

printf "%d\n", count_times('0?:00'); # 10
printf "%d\n", count_times('0?:0?'); # 10 * 10
printf "%d\n", count_times('0?:?0'); # 10 * 6
printf "%d\n", count_times('0?:??'); # 10 * 6 * 10

printf "%d\n", count_times('1?:00'); # 10
printf "%d\n", count_times('1?:0?'); # 10 * 10
printf "%d\n", count_times('1?:?0'); # 10 * 6
printf "%d\n", count_times('1?:??'); # 10 * 6 * 10

printf "%d\n", count_times('2?:00'); # 4
printf "%d\n", count_times('2?:0?'); # 4 * 10
printf "%d\n", count_times('2?:?0'); # 4 * 6
printf "%d\n", count_times('2?:??'); # 4 * 6 * 10

printf "%d\n", count_times('?0:00'); # 3
printf "%d\n", count_times('?0:0?'); # 3 * 10
printf "%d\n", count_times('?0:?0'); # 3 * 6
printf "%d\n", count_times('?0:??'); # 3 * 6 * 10

printf "%d\n", count_times('??:00'); # 24
printf "%d\n", count_times('??:0?'); # 24 * 10
printf "%d\n", count_times('??:?0'); # 24 * 6
printf "%d\n", count_times('??:??'); # 24
