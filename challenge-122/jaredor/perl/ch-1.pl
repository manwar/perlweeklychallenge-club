#!/usr/bin/env perl

# TWC 122, TASK #1 : Average of Stream

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
      "This script requires at least one number as an argument."
      unless @_;

    push @errors,
      "All arguments to this script must be numbers."
      unless all { looks_like_number($_) } @_;


    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( main_algo(@_) );
}

exit;    # End of main script.

# The main algorithm.

sub main_algo {

    my @avgs;
    my ($count, $total) = (0, 0.0);
    for my $num (@_) {
        $count += 1;
        $total += $num;
        push @avgs, $total / $count;
    }
    return @avgs;

}

# Report to STDOUT from user command line input.

sub output_results {

    say "Output: " . join(', ', @_);

}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my (@input, @output);

    @input  = (10, 20, 30, 40, 50, 60, 70, 80, 90, );
    @output = (10, 15, 20, 25, 30, 35, 40, 45, 50, );
    is_deeply( [ main_algo( @input ) ], \@output, "Test description" );

    done_testing();
}

__END__

=head1 NAME

TWC 122, TASK #1 : Average of Stream

=head1 SYNOPSIS

  ch-1.pl [options] number [number ...]

  Description:    Print a running average of a list of numbers.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    A non-empty list of numbers.

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

B<L<The Weekly Challenge, TASK #1 E<gt> Average of Stream|https://theweeklychallenge.org/blog/perl-weekly-challenge-122/#TASK1>>

I<Submitted by: Mohammad S Anwar>

You are given a stream of numbers, @N.

Write a script to print the average of the stream at every point.

=head2 Example

    Input: @N = (10, 20, 30, 40, 50, 60, 70, 80, 90, ...)
    Output:      10, 15, 20, 25, 30, 35, 40, 45, 50, ...

    Average of first number is 10.
    Average of first 2 numbers (10+20)/2 = 15
    Average of first 3 numbers (10+20+30)/3 = 20
    Average of first 4 numbers (10+20+30+40)/4 = 25 and so on.

=head1 INTERPRETATION

Despite the "Average of first (<count>) number(s)..." statements being in the Example section, I'm going to take them as explanatory of the output and not part of the output.

Also, for input I'm just going to take in whatever numbers are given on the command line, whitespace delimited.

=cut
