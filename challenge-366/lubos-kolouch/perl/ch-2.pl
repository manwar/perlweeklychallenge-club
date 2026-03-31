#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

=head1 NAME

ValidValidTimes - Count valid time strings in hh:mm format

=head1 SYNOPSIS

    use strict;
    use warnings;
    use lib '.';
    require ValidValidTimes;

    my $count = valid_valid_times("12:45", "25:00", "09:30", "23:59", "24:60");  # 2

=head1 DESCRIPTION

Given a list of time strings in hh:mm format, count how many are valid.
A time is valid if:
- Hour is between 00-23
- Minute is between 00-59

=head1 SUBROUTINES

=head2 valid_valid_times(@times)

    my $count = valid_valid_times("12:45", "25:00", "09:30");

Counts how many time strings are valid.

Parameters:
    @times - list of time strings in hh:mm format

Returns:
    Number of valid time strings.

=cut

sub valid_valid_times {
    my (@times) = @_;

    die "Error: times must be defined\n" unless @times;

    my $count = 0;
    for my $time (@times) {
        $count++ if _is_valid_time($time);
    }

    return $count;
}

=head2 _is_valid_time($time)

    my $valid = _is_valid_time("12:45");  # 1

Helper function to check if a time string is valid.

=cut

sub _is_valid_time {
    my ($time) = @_;

    return 0 unless defined $time;

    # Check format: must be exactly HH:MM
    unless ($time =~ /^(\d{2}):(\d{2})$/) {
        return 0;
    }

    my ($hour, $minute) = ($1, $2);

    # Validate ranges
    return 0 if $hour > 23;
    return 0 if $minute > 59;

    return 1;
}

=head2 _validate_time_format($time)

    my $is_valid = _validate_time_format("12:45");  # 1

Alternative validation with explicit checks.

=cut

sub _validate_time_format {
    my ($time) = @_;

    return 0 unless defined $time && $time =~ /^\d{2}:\d{2}$/;

    my ($h, $m) = split /:/, $time;
    return 0 if $h < 0 || $h > 23;
    return 0 if $m < 0 || $m > 59;

    return 1;
}

# Test cases
is(valid_valid_times("12:45", "25:00", "09:30", "23:59", "24:60"), 3, 'Example 1: 3 valid times (12:45, 09:30, 23:59)');
is(valid_valid_times("00:00", "23:59", "12:34", "24:00", "12:60"), 3, 'Example 2: boundary cases');
is(valid_valid_times("09:15", "14:30", "00:00", "12:00", "23:45"), 5, 'Example 3: all valid');
is(valid_valid_times("25:00", "12:60", "99:99", "ab:cd"), 0, 'Example 4: all invalid');
is(valid_valid_times("00:01", "01:00", "10:10", "23:59"), 4, 'Example 5: various valid');

done_testing();
