#!/usr/bin/env perl

# TWC 127, TASK #2 : Conflict Intervals

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use List::Util qw(all first min max);
use List::MoreUtils qw(uniq);

# For this challenge

#use Data::Dump qw(pp);

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'help|h!' => \( my $help ),
    'task|t!' => \( my $task ),
    'test'    => \( my $test )
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

$test ? test() : run(@ARGV);

exit;    # End of main script.

sub run {

    # Bundle up fatal input errors to report them all at once.

    my @errors;

    push @errors, "This script requires input of intervals as strings"
      unless @_;

    my $list = join( ' ', @_ );

    $list =~ s/[^-0-9]+/ /xmsg;
    $list =~ s/\A \s+ | \s+ \Z//xms;

    push @errors, "Octal numbers not allowed" if $list =~ /\b0\d/;

    my @list = split( /\s+/, $list );

    push @errors, "Missing an endpoint somewhere" if @list % 2;

    push @errors, "Not all integers" unless all { /\A -? \d+ \Z/xms } @list;

    my @intervals;
    push @intervals, [ $list[ 2 * $_ ], $list[ 2 * $_ + 1 ] ]
      for 0 .. ( $#list / 2 );

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( interval_intersections(@intervals) );
}

exit;    # End of main script.

# The main algorithm.

sub interval_intersections {

    my ( @ovals, @ivals );

    for my $ival (@_) {
        push @ovals, $ival if first { $ival->[1] >= $_->[0] }
                              grep { $ival->[0] <= $_->[1] } @ivals;
        push @ivals, $ival;
    }

    return @ovals;
}

# Report to STDOUT from user command line input.

sub output_results {

    say '[ ' . join( ', ', map { '(' . join( ',', @$_ ) . ')' } @_ ) . ' ]';

}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my ( @input, @output );

    @input = ( [ 1, 4 ], [ 3, 5 ], [ 6, 8 ], [ 12, 13 ], [ 3, 20 ] );
    @output = ( [ 3, 5 ], [ 3, 20 ] );

    is_deeply( [ interval_intersections(@input) ],
        \@output, "First example, passed" );

    @input = ( [ 3, 4 ], [ 5, 7 ], [ 6, 9 ], [ 10, 12 ], [ 13, 15 ] );
    @output = ( [ 6, 9 ] );
    is_deeply( [ interval_intersections(@input) ],
        \@output, "Second example, passed" );

    done_testing();
}

__END__

=head1 NAME

TWC 127, TASK #2 : Conflict Intervals

=head1 SYNOPSIS

  ch-2.pl [options] inverval_1, interval_2, ...

  Description:    Given a list of numeric intervals, find when there is overlap.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    
    A list of intervals in one or more strings. The input format is very flexible: The script extracts only the integers from the strings and then parses the integers in pairs as the bounds of an interval.

=head1 OPTIONS

=over 8

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=item B<--test>

Run the embedded test suite for this script.

=back

=head1 DESCRIPTION

B<L<The Weekly Challenge, TASK #2 E<gt> Disjoint Sets|https://theweeklychallenge.org/blog/perl-weekly-challenge-127/#TASK2>>

I<Submitted by: Mohammad S Anwar>

You are given a list of intervals.

Write a script to find out if the current interval conflicts with any of the previous intervals.

=head2 Example

Input: @Intervals = [ (1,4), (3,5), (6,8), (12, 13), (3,20) ]
Output: [ (3,5), (3,20) ]

    - The 1st interval (1,4) do not have any previous intervals to compare with, so skip it.
    - The 2nd interval (3,5) does conflict with previous interval (1,4).
    - The 3rd interval (6,8) do not conflicts with any of the previous intervals (1,4) and (3,5), so skip it.
    - The 4th interval (12,13) again do not conflicts with any of the previous intervals (1,4), (3,5) and (6,8), so skip it.
    - The 5th interval (3,20) conflicts with the first interval (1,4).

Input: @Intervals = [ (3,4), (5,7), (6,9), (10, 12), (13,15) ]
Output: [ (6,9) ]

    - The 1st interval (3,4) do not have any previous intervals to compare with, so skip it.
    - The 2nd interval (5,7) do not conflicts with the previous interval (3,4), so skip it.
    - The 3rd interval (6,9) does conflict with one of the previous intervals (5,7).
    - The 4th interval (10,12) do not conflicts with any of the previous intervals (3,4), (5,7) and (6,9), so skip it.
    - The 5th interval (13,15) do not conflicts with any of the previous intervals (3,4), (5,7), (6,9) and (10,12), so skip it.

=head1 INTERPRETATION

Are the intervals open? closed? The examples don't clarify this point, unfortunately. So I'm going to make it easy on myself, all intervals are closed and hence contain their endpoints. Thus (0,1) and (1,2) do intersect.

The interval endpoints in the examples are all integers. Normally, I would try to make this work for all real numbers, but using integers makes the coding a lot easier, so let's do that.

=cut
