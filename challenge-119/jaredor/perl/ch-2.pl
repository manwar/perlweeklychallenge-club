#!/usr/bin/env perl

# PWC 119, TASK #2 : Sequence without 1 on 1

use v5.012;
use strict;
use warnings;
use integer;
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

    push @errors, "This script requires exactly one positive integer as an argument."
      unless @_ == 1;
    push @errors, "The argument must be a positive integer."
      unless $_[0] =~ /\A \d+ \Z/xms and $_[0] > 0;

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    my $nth_seq123 = get_nth(&seq123);

    output_results( $nth_seq123->( $_[0] ) );

}

# The main algorithm.

sub seq123 {
    my @seq = 1 .. 3;
    return sub {
        $_ !~ /11$/ and push @seq, $_ for ( $seq[0] . 1 ) .. ( $seq[0] . 3 );
        return shift @seq;
    };

}

sub get_nth {
    my ( $seq, ) = @_;
    return sub {
        my $n = $_[0];
        $seq->() and $n -= 1 while $n > 1;
        return $seq->();
      }
}

# Report to STDOUT from user command line input.

sub output_results {
    say $_[0];
}

# Built in test for the algorithm function.

sub test {

    use Test::More;

    my ( $input, $output );
    my $nth_seq123 = get_nth(&seq123);

    ( $input, $output ) = ( 5, 13 );
    is_deeply( get_nth(&seq123)->($input),
        $output, "First Example: $input -> $output" );

    ( $input, $output ) = ( 10, 32 );
    is_deeply( get_nth(&seq123)->($input),
        $output, "Second Example: $input -> $output" );

    ( $input, $output ) = ( 60, 2223 );
    is_deeply( get_nth(&seq123)->($input),
        $output, "Third Example: $input -> $output" );

    my @input = (1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, );
    my @output;
    push @output, get_nth(&seq123)->($_) for 1 .. @input;
    is_deeply( \@input, \@output, "First 15 in problem description is correct.");

    done_testing();
}

__END__

=head1 NAME

PWC 119, TASK #2 : Sequence without 1-on-1

=head1 SYNOPSIS

  ch-2.pl [options] arg

  Description:    1,2,3 sequence without adjacent 1's.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    A positive integer representing the order of the element in the list to return.

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

B<L<Perl Weekly Challenge, TASK #2 E<gt> Sequence without 1-on-1|https://theweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK2>>

I<Submitted by: Cheok-Yin Fung>

Write a script to generate sequence starting at 1. Consider the increasing sequence of integers which contain only 1's, 2's and 3's, and do not have any doublets of 1's like below. Please accept a positive integer $N and print the $Nth term in the generated sequence.

    1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...

    Example

=head2 Example

=over 4

    Input: $N = 5
    Output: 13

    Input: $N = 10
    Output: 32

    Input: $N = 60
    Output: 2223

=back

=head1 INTERPRETATION

This is how I refined or changed the statement of the problem.

=head2 OBSERVATIONS

The problem statement is pretty straightforward.

I did not try to recast the solution to take advantage of memoization, which would have helped with testing, but not necessarily with the active use of the script, which is a one-shot deal.

=head2 RESTATEMENT

List, in ascending numerical order, all numbers that consist only of the digits 1, 2 and 3, with all numbers with adjacent 1's excluded.

=head1 SEE ALSO

L<Higher Order Perl: Chapter 5, From Recursion to Iterators|https://hop.perl.plover.com/book/pdf/05FromRecursionToIterators.pdf>

=cut
