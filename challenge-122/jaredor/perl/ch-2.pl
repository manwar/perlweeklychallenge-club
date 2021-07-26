#!/usr/bin/env perl

# TWC 122, TASK #2 : Basketball Points

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

# For this challenge

use Data::Dump qw(pp);

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
      "This script requires exactly one positive integer as an argument."
      unless 1 == @_ and $_[0] =~ /\d+/ and $_[0] > 0;


    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( main_algo(@_) );
}

exit;    # End of main script.

# The main algorithm.

sub main_algo {

    my @bb_points = (1, 2, 3);

    my $target = $_[0];
    my @scores = ();
    if ($target > 0) {
        for my $bb_pnt (@bb_points) {
            if ($bb_pnt < $target) {
                for my $partial (@{&main_algo($target - $bb_pnt)}) {
                    push @scores, [ $bb_pnt, @{$partial} ];
                }
            } elsif ($bb_pnt == $target) {
                push @scores, [ $bb_pnt, ];
            }
        }
    }
    return \@scores;
}

# Report to STDOUT from user command line input.

sub output_results {

    my $leader = "Output: ";
    for my $scores (@{$_[0]}) {
        say $leader . join(' ', @{$scores});
        $leader = "        ";
    }

}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    # Ran out of time, no built-in testing. You'll have to try it and see :-)
    #$input = [ 4, ];
    #pp main_algo($input);
    #is_deeply( main_algo( $input ), [ ], "Test description" );


    done_testing();
}

__END__

=head1 NAME

TWC 122, TASK #2 : Basketball Points

=head1 SYNOPSIS

  ch-1.pl [options] <score>

  Description:    Produce every combination of basketball goals to achieve input score.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    A positive integer to represent the basketball score.

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

B<L<The Weekly Challenge, TASK #1 E<gt> Basketball Points|https://theweeklychallenge.org/blog/perl-weekly-challenge-122/#TASK2>>

I<Submitted by: Mohammad S Anwar>

    You are given a score $S.

    You can win basketball points e.g. 1 point, 2 points and 3 points.

    Write a script to find out the different ways you can score $S.

=head2 Example

Input: $S = 4
Output: 1 1 1 1
        1 1 2
        1 2 1
        1 3
        2 1 1
        2 2
        3 1

Input: $S = 5
Output: 1 1 1 1 1
        1 1 1 2
        1 1 2 1
        1 1 3
        1 2 1 1
        1 2 2
        1 3 1
        2 1 1 1
        2 1 2
        2 2 1
        2 3
        3 1 1
        3 2

=head1 INTERPRETATION

Forbid non-positive integer scores.

=cut
