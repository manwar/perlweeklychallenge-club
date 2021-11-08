#!/usr/bin/env perl

# TWC 120, TASK #1 : Swap Odd/Even bits

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

    push @errors, "This script requires one positive integer as an argument."
      unless @_ == 1;

    push @errors, "The argument is not a positive decimal integers"
      unless $_[0] =~ /\A \d+ \Z/xms;

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.

    output_results( bit_swap(@_) );
}

exit;    # End of main script.

# The main algorithm.

sub bit_swap {

    use bigint;

    # It came out in testing that the Number '2' had to be copied
    # as a bigint object when creating $bmask. It would work the
    # first time, but then fail the second, otherwise.

    my $num = $_[0] + 0;
    my ( $num_e, $num_o, $bmask, ) = ( $num->copy(), $num->copy(), 2->copy() );
    $bmask->blsft(2)->bior(2) until $bmask->bge($num);
    $num_e->band($bmask);
    $bmask->brsft(1);
    $num_o->band($bmask);
    $num_e->brsft(1);
    $num_o->blsft(1);
    return $num_o->bior($num_e);
}

# Report to STDOUT from user command line input.

sub output_results {

    say @_;

}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    $input = 101;
    is_deeply( bit_swap($input), 154, "First example: 101 -> 154" );

    $input = 18;
    is_deeply( bit_swap($input), 33, "Second example: 18 -> 33" );

    $input = 51;
    is_deeply( bit_swap($input), 51,
        "Identity for numbers with 'twinned bits': 51." );

    $input = 2**16 - 1;
    is_deeply( bit_swap($input), 65535,
        "Identity for numbers with 'twinned bits': 65535." );

    done_testing();
}

__END__

=head1 NAME

TWC 120, TASK #1 : Swap Odd/Even bits

=head1 SYNOPSIS

  ch-1.pl [options] nonnegint

  Description:    bit-swap the binary representation of positive integers.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    A non-empty list of positive integers

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

Used bigint to extend the range of input numbers.

=cut
