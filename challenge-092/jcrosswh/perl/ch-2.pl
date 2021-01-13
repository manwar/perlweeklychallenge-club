#!/usr/bin/env perl

use strict;
use warnings;

=head1 NAME

PWC 092 Challenge 2

=head1 SYNOPSIS

  $ ch-2.pl (1,9),(13,19),(25,26) (8,14)
  (1,19),(25,26)

=head1 DESCRIPTION

Given a set of sorted non-overlapping intervals and a new interval, this script
will merge the new interval into the given set of intervals.

=head1 SOLUTION

This script takes in two inputs, the first is a list of intervals and the second
is a new interval that should be added.  This script does not currently work
with negative numbers, nor does it do any sanity checking that the input is
sorted and non-overlapping (I didn't get around to checking that.)

This script works by first parsing the existing intervals data into an array of
arrays, with each array holding two values that denote the start and end of the
interval.

It then goes though to determine where to insert the new interval.  It checks:

 1. Does the new interval just go to the beginning of the set.
 2. Does the new interval just go to the end of the set.
 3. Does the new interval span all other intervals, so it just becomes the new
interval.
 4. The new interval needs to go into the existing set, so starts looping
through existing intervals:
  a. Checks if the new interval lands in between the current and the next
interval.
  b. Checks if the start of the new interval is before the existing interval, if
so, then set the current interval start to the new interval start.
  c. Checks if the end of the new interval is after the existing interval, if so,
then set the end of the current interval to the new interval end.
  d. If the new interval connects two intervals, then set the correct beginning
and end, then delete the second interval from the current set.

=head1 AUTHORS

Joel Crosswhite E<lt>joel.crosswhite@ix.netcom.comE<gt>

=cut

my $intervals = $ARGV[0];
my $new_interval = $ARGV[1];
if ((!defined($intervals) || $intervals !~ m/^(\(\d+\,\d+\),)*\(\d+\,\d+\)$/)
    || (!defined($new_interval) || $new_interval !~ m/^\((\d+)\,(\d+)\)$/)) {
    print "Usage: ch-2.pl (#,#),(#,#),..(#,#) (#,#)\n";
    exit 1;
}

# fetched from input validation regex
my $new_interval_start = $1;
my $new_interval_end = $2;

my @intervals_ds;
extract_intervals($intervals, \@intervals_ds);

# if new interval is before all others....
if ($new_interval_end < $intervals_ds[0][0]) {
    splice(@intervals_ds, 0, 0, [$new_interval_start, $new_interval_end]);
    
# if new inteval is after all others....
} elsif ($new_interval_start > $intervals_ds[-1][1]) {
    splice(@intervals_ds, scalar(@intervals_ds), 0,
        [$new_interval_start, $new_interval_end]);
        
# if new interval spans all intervals....
} elsif ($new_interval_start < $intervals_ds[0][0]
    && $new_interval_end > $intervals_ds[-1][1]) {
    @intervals_ds = [$new_interval_start, $new_interval_end];
} else {
    
    # go through all existing intervals to see where new one should land
    for (my $i = 0; $i < scalar(@intervals_ds) - 1; $i++) {
        
        # new interval falls in between existing intervals
        if ($new_interval_start > $intervals_ds[$i][1]
            && $new_interval_end < $intervals_ds[$i + 1][0]) {
            splice(@intervals_ds, $i + 1, 0,
                [$new_interval_start, $new_interval_end]);
            last;
        }
        
        # new interval will extend existing interval forward
        if ($new_interval_start < $intervals_ds[$i][0]
            && $new_interval_end > $intervals_ds[$i][0]) {
            $intervals_ds[$i][0] = $new_interval_start;
        }
        
        # new interval will extend existing interval further back
        if ($new_interval_end > $intervals_ds[$i][1]
            && $new_interval_end < $intervals_ds[$i + 1][0]) {
            $intervals_ds[$i][1] = $new_interval_end;
        }
        
        # new interval 'connects' two intervals, requiring the removal of one
        if ($new_interval_start < $intervals_ds[$i][1]
            && $new_interval_end > $intervals_ds[$i + 1][0]) {
            $intervals_ds[$i][1] = $intervals_ds[$i + 1][1];
            splice(@intervals_ds, $i + 1, 1);
        }
    }
}

print_intervals(\@intervals_ds);
exit 0;

sub extract_intervals {
    my ($input, $intervals) = @_;
    
    my $pair_idx = 0;
    foreach my $character (split(/[\)\,\(]/, $input)) {
        next if $character eq ''; # just skip blank strings that can come in
        if ($pair_idx++ % 2 == 0) {
            push(@{$intervals}, [$character]);
        } else {
            push(@{$intervals->[-1]}, $character);
        }
    }
}

sub print_intervals {
    my ($intervals) = @_;

    my $output = '';
    foreach my $interval (@{$intervals}) {
        $output .= sprintf('(%d,%d),', $interval->[0], $interval->[1]);
    }
    chop($output);
    print $output . "\n";
}