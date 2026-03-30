#!/usr/bin/env perl
use strict;
use warnings;

=head1 NAME

ConflictEvents - Check if two events conflict

=head1 SYNOPSIS

    perl ch-2.pl <start1> <end1> <start2> <end2>

Times in HH:MM format.

=head1 DESCRIPTION

Given two events each with start and end time, find out if there is a conflict between them. A conflict happens when two events have some non-empty intersection.

=cut

sub time_to_minutes {
    my ($time) = @_;
    my ($h, $m) = split /:/, $time;
    return $h * 60 + $m;
}

sub has_conflict {
    my ($start1, $end1, $start2, $end2) = @_;
    my $s1 = time_to_minutes($start1);
    my $e1 = time_to_minutes($end1);
    my $s2 = time_to_minutes($start2);
    my $e2 = time_to_minutes($end2);
    # Overlap if max(s1,s2) < min(e1,e2)
    return ($s1 < $e2 && $s2 < $e1) ? 1 : 0;
}

# Test cases
use Test::More tests => 4;

is(has_conflict('10:00', '11:00', '11:00', '12:00'), 0, 'Example 1: no overlap (touching)');
is(has_conflict('10:00', '11:00', '10:30', '11:30'), 1, 'Example 2: overlap');
is(has_conflict('09:00', '10:00', '10:00', '11:00'), 0, 'Adjacent events');
is(has_conflict('08:00', '12:00', '10:00', '14:00'), 1, 'Partial overlap');

=head1 EXAMPLES

    perl ch-2.pl 10:00 11:00 11:00 12:00
    # Output: 0 (no conflict)

    perl ch-2.pl 10:00 11:00 10:30 11:30
    # Output: 1 (conflict)

=cut
