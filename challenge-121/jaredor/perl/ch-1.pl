#!/usr/bin/env perl

# TWC 121, TASK #1 : Invert Bit

use v5.012;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;

# For this challenge

use Data::Dump qw(pp);
use List::Util qw(all);    # To check all the input args

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'help|h!' => \( my $help ),
    'task|t!' => \( my $task ),
    'test'    => \( my $test ),
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

$test ? test() : run(@ARGV);

exit;    # End of main script.

sub run {


    # Bundle up fatal input errors to report them all at once.

    my @errors;

    push @errors, "This script requires two arguments." unless 2 == @_;

    push @errors, "The arguments must be integers." unless all { /\d+/ } @_;

    push @errors, "The second argument must be a positive integer." unless $_[1] > 0;

    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    # Get the solution.
 
    output_results( main_algo(@_) );
}

exit;    # End of main script.

# The main algorithm.

sub main_algo {

    use bigint;

    my ($m, $n) = map { $_ + 0 } @_;
    my ($m_bstr, $m_bin, $tmp) = ($m->bstr(), substr($m->as_bin(), 2), $m->copy());
    my $mask = 2**($n-1);
    $tmp->band($mask);

    # Desired bit manipulation, but bigint does a twos-complement negation :-(
    # my $result = $m & $mask ? $m & ~$mask : $m | $mask;

    my $result = $tmp ? $m - $mask : $m + $mask; # Resort to arithmetic

    return [ $m_bstr, $m_bin, $n->bstr(), $result->bstr(), substr($result->as_bin(), 2) ];

}

# Report to STDOUT from user command line input.

sub output_results {

    pp $_[0];
    my ($m, $m_bin, $n, $result, $result_bin,) = @{$_[0]};
    say join(" ", @{$_[0]});

    $m_bin = '0' x (length($result_bin) - length($m_bin)) . $m_bin if length($m_bin) < length($result_bin);

    say "Input: \$m = $m, \$n = $n";
    say "Output: $result\n";

    say "Binary representation of \$m = $m_bin";

    my $stndrdth = $n == 1 ? 'st' : $n == 2 ? 'nd' : $n == 3 ? 'rd' : 'th';
    say "Invert $n$stndrdth bit from the end = $result_bin";

    say "Decimal equivalent of $result_bin = $result";
}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    $input = [ 12, 3, ];
    is_deeply( main_algo( @{$input} ), [ 12, 1100, 3, 8, 1000, ], "Example 1" );
    
    $input = [ 18, 4, ];
    is_deeply( main_algo( @{$input} ), [ 18, 10010, 4, 26, 11010, ], "Example 2" );
    
    done_testing();
}

__END__

=head1 NAME

TWC 121, TASK #1 : Invert Bit

=head1 SYNOPSIS

  ch-1.pl [options] m n

  Description:    Invert bit n in the binary representation of integer m.

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    m             The non-negative integer to have its bit inverted.
    n             The ordinal bit to invert in m.

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

B<L<The Weekly Challenge, TASK #1 E<gt> Invert Bit/Even bits|https://theweeklychallenge.org/blog/perl-weekly-challenge-121/#TASK1>>

I<Submitted by: Mohammad S Anwar>

You are given integers 0 <= $m <= 255 and 1 <= $n <= 8.

Write a script to invert $n bit from the end of the binary representation of $m and print the decimal representation of the new binary number.

=head2 Example

=over 4

Input: $m = 12, $n = 3
Output: 8

Binary representation of $m = 00001100
Invert 3rd bit from the end = 00001000
Decimal equivalent of 00001000 = 8

Input $m = 18, $n = 4
Output: 26

Binary representation of $m = 00010010
Invert 4th bit from the end = 00011010
Decimal equivalent of 00011010 = 26

=back

=head1 INTERPRETATION

This solution will use bigint and just require that $m be a non-negative integer and $n be a positive integer.

=cut
