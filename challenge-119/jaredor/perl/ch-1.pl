#!/usr/bin/env perl

# TWC 119, TASK #1 : Swap Nibbles

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

    output_results( nybble_swap(@_) );
}

# The main algorithm.

sub nybble_swap {

    my $swapped;
    for my $dnum ( map { 0 + $_ } grep { /^\d+$/ } @_ ) {
        my @hnum = ( '0', split( '', substr( $dnum->as_hex, 2 ) ) );
        shift @hnum if @hnum % 2;
        push @{$swapped},
          hex( '0x' . join( '', @hnum[ map { $_ ^ 1 } 0 .. $#hnum ] ) );
    }
    return $swapped;
}

# Report to STDOUT from user command line input.

sub output_results {
    my @results = @{ $_[0] };
    say join( ' ', @results );
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

B<L<The Weekly Challenge, Task #1 E<gt> Swap Nibbles|https://theweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK1>>

I<Submitted by: Mohammad S Anwar>

You are given a positive integer $N.

Write a script to swap the two nibbles of the binary representation of the given number and print the decimal number of the new binary representation.

=head2 Example

=over 4

    A nibble is a four-bit aggregation, or half an octet.

    To keep the task simple, we only allow integer less than or equal to 255.
    Example

    Input: $N = 101
    Output: 86

    Binary representation of decimal 101 is 1100101 or as 2 nibbles (0110)(0101).
    The swapped nibbles would be (0101)(0110) same as decimal 86.

    Input: $N = 18
    Output: 33

    Binary representation of decimal 18 is 10010 or as 2 nibbles (0001)(0010).
    The swapped nibbles would be (0010)(0001) same as decimal 33.

=back

=head1 INTERPRETATION

This is how I refined or changed the statement of the problem.

=head2 OBSERVATIONS

When I read the problem description from the Perl Weekly newsletter, it didn't have the restriction on the size of $N, so this works with arbitrarily large integers.

This will correctly handle the value 0, so the domain of allowable input is the set of non-negative integers. Only decimal integers are allowed.

Zero-nybble padding the number at the high end means that the answer will be the same, regardless of whether the binary representation is big-endian or little-endian, since an even number of nybbles means that every swap takes place within a byte.

I decided to enable this script to nybble-swap a list of non-negative integers instead of just one.

I like the variant spelling nybble :-)

=head2 RESTATEMENT

Given a list of non-negative integers, for each respective integer, return the number that corresponds to the binary representation of the input number with adjacent nybbles switched. Thus nybble 1 and nybble 2 get swapped, nybble 3 and nybble 4 get swapped, etc. If the number of non-zero nybbles in the binary representation is odd, then a 0000 nybble is padded "beyond" the highest order nybble.

=head1 SEE ALSO

L<Nibble|https://en.wikipedia.org/wiki/Nibble>

L<Endianness|https://en.wikipedia.org/wiki/Endianness>

L<use xor on the array indexes|https://www.perlmonks.org/?node_id=891512>
=cut
