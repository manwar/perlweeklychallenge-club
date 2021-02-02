#!/usr/bin/env perl
# Perl weekly challenge 092
# Task 2: Insert interval.
# Make a sorted list of non-overlapping intervals by adding or merging new intervals.
# See https://wlmb.github.io/2020/12/22/PWC92/#task-2-insert-interval
use warnings;
use strict;
use v5.10;
use Scalar::Util qw(looks_like_number);
use List::Util qw(first min max);

my @intervals;
foreach(split ' ', shift @ARGV){
    usage() unless /^\((.*),(.*)\)$/
		       and looks_like_number($1) and looks_like_number($2)
		       and $1<$2;
    add_interval([$1,$2]);
}
# print the results
print_interval($_) foreach(@intervals);
say '';

# add interval to ordered @intervals array merging overlapping intervals
sub add_interval {
    my $interval=shift;
    my $first=first {$interval->[0]<$intervals[$_][1]} (0..$#intervals);
    my $last=first {$interval->[1]>$intervals[$_][0]} reverse(0..$#intervals);
    push(@intervals, $interval), return unless defined $first;
    unshift(@intervals, $interval), return  unless defined $last;
    splice(@intervals, $first, 0, $interval), return if $last<$first;
    splice @intervals, $first, $last+1-$first,
	[min($intervals[$first][0], $interval->[0]),
	 max($intervals[$last][1], $interval->[1])];
}

sub print_interval {
    my $interval=shift @_;
    print "($interval->[0],$interval->[1]) ";
}
sub usage {
    say <<'END_USAGE';
Usage: ./ch-2.pl "(l0,u0) (l1,u1),..."
where ln<un are numbers and there is no space within the parenthesis.
END_USAGE
    exit 1;
}
