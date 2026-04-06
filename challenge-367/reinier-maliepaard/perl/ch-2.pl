#!/usr/bin/perl
use strict;
use warnings;

use constant DAY => 1440; # number of minutes in one day (24 * 60)

sub conflict_events {
    my ($ev1, $ev2) = @_;

    # --- Step 0: Validate input structure ----------------------------

    # Expect two array references with exactly two elements each
    return unless ref $ev1 eq 'ARRAY' && ref $ev2 eq 'ARRAY';
    return unless @$ev1 == 2 && @$ev2 == 2;

    # Optional: ensure defined values
    return unless defined $ev1->[0] && defined $ev1->[1];
    return unless defined $ev2->[0] && defined $ev2->[1];

    # --- Step 1: Convert times to minutes ----------------------------

    # Explicit version
    # my $s1 = _to_minutes($ev1->[0]);
    # my $e1 = _to_minutes($ev1->[1]);
    # my $s2 = _to_minutes($ev2->[0]);
    # my $e2 = _to_minutes($ev2->[1]);

    # Compact / idiomatic version
    my ($start1, $end1) = map { _to_minutes($_) } @$ev1;
    my ($start2, $end2) = map { _to_minutes($_) } @$ev2;

    # --- Step 2: Normalize events crossing midnight ------------------

    # If end < start, the event continues into the next day
    $end1 += DAY if $end1 < $start1;
    $end2 += DAY if $end2 < $start2;

    # --- Step 3: Check overlap ---------------------------------------

    # Overlap occurs if each event starts before the other ends

    # Direct condition (compact but less flexible)
    # return "True" if ($start1 < $end2 && $start2 < $end1) ||
    #                  ($start1 < $end2 + DAY && $start2 + DAY < $end1);

    # Loop version (clear and extensible)
    for my $shift (0, DAY) {
        my $s2_shift = $start2 + $shift;
        my $e2_shift = $end2   + $shift;

        return "True" if $start1 < $e2_shift && $s2_shift < $end1;
    }

    return "False";
}

sub _to_minutes {
    my ($t) = @_;

    # Basic validation (didactic, not exhaustive)
    return unless defined $t && $t =~ /^\d{1,2}:\d{2}$/;

    my ($h, $m) = split /:/, $t;
    return $h * 60 + $m;
}

# Tests
my @event1;
my @event2;

# Example 1
@event1 = ("14:00", "15:30");
@event2 = ("14:30", "16:00");
print conflict_events(\@event1, \@event2), "\n"; # Output: True

# Example 2
@event1 = ("14:30", "16:00");
@event2 = ("14:00", "15:30");
print conflict_events(\@event1, \@event2), "\n"; # Output: True

# Example 3
@event1 = ("09:00", "10:30");
@event2 = ("10:30", "12:00");
print conflict_events(\@event1, \@event2), "\n"; # Output: False

# Example 4
@event1 = ("14:00", "15:30");
@event2 = ("14:30", "16:00");
print conflict_events(\@event1, \@event2), "\n"; # Output: True

# Example 5
@event1 = ("08:00", "09:00");
@event2 = ("09:01", "10:00");
print conflict_events(\@event1, \@event2), "\n"; # Output: False

# Example 6
@event1 = ("23:30", "00:30");
@event2 = ("00:00", "01:00");
print conflict_events(\@event1, \@event2), "\n"; # Output: True
