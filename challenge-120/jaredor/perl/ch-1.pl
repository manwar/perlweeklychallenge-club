#!/usr/bin/env perl

# TWC 120, TASK #1 : Swap Odd/Even bits

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

# For this challenge

use bigint;                # To allow for arbitrarily long hexstrings
use List::Util qw(all);    # To check all the input args

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
      "This script requires at least one non-negative integer as an argument."
      unless @_;

    push @errors, "Not all arguments are non-negative decimal integers."
      unless all { /\A (?:0 | [1-9] \d*) \Z/xms } @_;

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( main_algo(@_) );
}

exit;    # End of main script.

# The main algorithm.

sub main_algo {

}

# Report to STDOUT from user command line input.

sub output_results {

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

TWC 119, TASK #1 : Swap Nibbles

=head1 SYNOPSIS

  ch-1.pl [options] nonnegint [nonnegint ...]

  Description:    Nybble-swap the binary representation of non-negative integers.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    A non-empty list of non-negative integers

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

B<L<The Weekly Challenge, TASK #1 E<gt> Swap Odd/Even bits|https://theweeklychallenge.org/blog/perl-weekly-challenge-120/#TASK1>>

I<Submitted by: Mohammad S Anwar>

You are given a positive integer $N less than or equal to 255.

Write a script to swap the odd positioned bit with even positioned bit and print the decimal equivalent of the new binary representation.

=head2 Example

=over 4

Input: $N = 101
Output: 154

Binary representation of the given number is 01 10 01 01.
The new binary representation after the odd/even swap is 10 01 10 10.
The decimal equivalent of 10011010 is 154.

Input: $N = 18
Output: 33

Binary representation of the given number is 00 01 00 10.
The new binary representation after the odd/even swap is 00 10 00 01.
The decimal equivalent of 100001 is 33.

=back

=head1 INTERPRETATION

The Resolve grey areas in problem statement.

=cut
