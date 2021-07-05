#!/usr/bin/env perl

# TWC 119, TASK #1 : Swap Nibbles

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

# For this challenge

# use Data::Dump qw(pp);

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

    push @errors, "This script takes exactly one argument."
      unless 1 == @_;

    my $time = $_[0];

    if ( $time =~ /\A \d \d : \d \d \Z/xms ) {
        my ( $h, $m ) = ($time =~ /\A ( 0? \d+ ) : ( 0? \d+ ) \Z/xms);

        push @errors, "Hours are out-of-range: 01 - 12."
          unless 1 <= $h and $h <= 12;

        push @errors, "Minutes are out-of-range: 00 - 59."
          unless 0 <= $m and $m <= 59;
    }
    else {
        push @errors, "The argument is not in \"hh:mm\" format: $time";
    }

    pod2usage( ( join "\n", map { "ERROR: " . $_ } @errors ) . "\n" )
      if @errors;

    # Get the solution.

    output_results( minute_hand_hour_hand_angle($time) );
}

exit;    # End of main script.

# The main algorithm.

sub minute_hand_hour_hand_angle {

    my ( $hours, $minutes ) = ($_[0] =~ /\A ( 0? \d+ ) : ( 0? \d+ ) \Z/xms);

    # Degrees are measured from 12 o'clock position, clockwise.

    $hours = 0 if $hours == 12; # Make 12 o'clock now 0 o'clock.

    my $mdeg = 6 * $minutes; # Each minute is 6 degrees.

    # Each hour is 30 degrees plus ...
    # ... 30 degrees times the ratio of current minutes to an hour of minutes.

    my $hdeg = 30 * ($hours + $minutes / 60);

    my $angle = abs($hdeg - $mdeg);

    return $angle > 180 ? 360 - $angle : $angle;

}

# Report to STDOUT from user command line input.

sub output_results {
    say "$_[0] degrees";
}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    $input = [ 101, ];
    is_deeply( nybble_swap( @{$input} ), [ 86, ], "First example: 101 -> 86" );

    $input = [ 18, ];
    is_deeply( nybble_swap( @{$input} ), [ 33, ], "Second example: 18 -> 33" );

    $input = [ 0 .. 255 ];
    is_deeply( nybble_swap( @{ nybble_swap( @{$input} ) } ),
        $input, "Composition is identity." );

    $input = [ map { 16 * $_ + $_ } 0 .. 15 ];
    is_deeply( nybble_swap( @{$input} ),
        $input, "Bytes of twin nybbles are unchanged." );

    my $p = 1279;
    $input = [ 2**( $p - 1 ) * ( 2**$p - 1 ) ];
    is_deeply( nybble_swap( @{ nybble_swap( @{$input} ) } ),
        $input, "Handles a special 770 digit number." );

    done_testing();
}

__END__

=head1 NAME

TWC 120, TASK #2 : Clock Angle

=head1 SYNOPSIS

  ch-1.pl [options] <hh:mm>

  Description:    Return angle between two hands of an analog clock.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    The time in "hh:mm" format that specifies where the hands are.

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

B<L<The Weekly Challenge, TASK #2 E<gt> Clock Angle|https://theweeklychallenge.org/blog/perl-weekly-challenge-120/#TASK1>>

I<Submitted by: Mohammad S Anwar>

You are given time $T in the format hh:mm.

Write a script to find the smaller angle formed by the hands of an analog clock at a given time.
HINT: A analog clock is divided up into 12 sectors. One sector represents 30 degree (360/12 = 30).

=head2 Example

=over 4

Input: $T = '03:10'
Output: 35 degree

The distance between the 2 and the 3 on the clock is 30 degree.
For the 10 minutes i.e. 1/6 of an hour that have passed.
The hour hand has also moved 1/6 of the distance between the 3 and the 4, which adds 5 degree (1/6 of 30).
The total measure of the angle is 35 degree.

Input: $T = '04:00'
Output: 120 degree

=back

=head1 INTERPRETATION

The Resolve grey areas in problem statement.

=cut
