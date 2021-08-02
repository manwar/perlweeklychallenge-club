#!/usr/bin/env perl

# TWC 123, TASK #2 : Square Points

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

# For this challenge

use List::Util qw(all);    # To check all the input args
use Scalar::Util qw(looks_like_number);
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

    push @errors,
      "This script requires four points as arguments."
      unless 4 == @_;

    push @errors,
      "A point is of the format <X-coord>,<Y-coord> with <XY-coord> a number and *no* *whitespace*"
      unless all { /\A ([^,]+) , ([^,]+) \Z/xms and looks_like_number($1) and looks_like_number($2) } @_;


    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( ima_square(@_) );
}

exit;    # End of main script.

# The main algorithm.

sub ima_square {

    # Don't need to take the sqrt for the result, but doing so means the tolerance is
    # more understandible to the user.

    my @points = map { [ split ',' ] } @_;
    my @lengths;
    for my $pnt1 (0..($#points-1)) {
        for my $pnt2 (($pnt1+1)..$#points) {
            push @lengths, sqrt(($points[$pnt1]->[0] - $points[$pnt2]->[0])**2 + ($points[$pnt1]->[1] - $points[$pnt2]->[1])**2);
        }
    }
    @lengths = sort { $a <=> $b } @lengths;

    my $tolerance = 0.0001;

    return (abs($lengths[3]  - $lengths[0]) < $tolerance and abs($lengths[5] - $lengths[4]) < $tolerance);

}

# Report to STDOUT from user command line input.

sub output_results {

    my ($is_square,) = @_;
    if ($is_square) {
        say "1 as the given coordinates form a square.";
    } else {
        say "0 as the given coordinates don't form a square.";
    };
}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    $input = [ '10,20', '20,20', '20,10', '10,10', ];
    is_deeply( ima_square( @{$input} ), 1, "Test description" );

    $input = [ '12,24', '16,10', '20,12', '18,16', ];
    is_deeply( ima_square( @{$input} ), !1, "Test description" );

    done_testing();
}

__END__

=head1 NAME

TWC 123, TASK #2 : Square Points

=head1 SYNOPSIS

  ch-2.pl [options] <point1> <point2> <point3> <point4>

  Description:    Determine if the four given points are the corners of a square.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    Four points of the format <number>,<number> where the X and Y coordinates are
    comma separated--no whitespace withing a coordinate!

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

B<L<The Weekly Challenge, TASK #2 E<gt> Square Points|https://theweeklychallenge.org/blog/perl-weekly-challenge-123/#TASK2>>

I<Submitted by: Mohammad S Anwar>

You are given coordinates of four points i.e. (x1, y1), (x2, y2), (x3, y3) and (x4, y4).

Write a script to find out if the given four points form a square.

=head2 Example

=over 4

Input: x1 = 10, y1 = 20
       x2 = 20, y2 = 20
       x3 = 20, y3 = 10
       x4 = 10, y4 = 10
Output: 1 as the given coordinates form a square.

Input: x1 = 12, y1 = 24
       x2 = 16, y2 = 10
       x3 = 20, y3 = 12
       x4 = 18, y4 = 16
Output: 0 as the given coordinates doesn't form a square.

=back

=head1 INTERPRETATION

Made up a quick-and-dirty input format for the point.

This should work for all numeric coordinates.

=cut
