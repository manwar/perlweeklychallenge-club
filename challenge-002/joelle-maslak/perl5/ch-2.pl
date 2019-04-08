#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

# Challenge:
#   Write a script that can convert integers to and from a base35
#   representation, using the characters 0-9 and A-Y. Dave Jacoby came
#   up with nice description about base35, in case you needed some
#   background.
#
# Assumptions:
#   * This should be case-insensitive on input
#   * This should use only upper case on output
#   * Negative numbers should be accepted.
#   * Only integers are handled
#
#   Example input/output:
#     perl 2.pl encode 10    --> A
#     perl 2.pl encode 100   --> 2U
#     perl 2.pl encode -10   --> -A
#     perl 2.pl decode A     --> 10
#     perl 2.pl decode 2U    --> 100
#     perl 2.pl decode -A    --> -10
#
#
# Implementation:
#   This is essentially two programs, one to convert decimal integer to
#   a base 35 integer, the other to do the reverse.
#
#   We start by parsing the arguments on the command line.  The first
#   argument is used to determine if we "encode" (convert decimal -->
#   Base35) or "decode" (convert Base35 --> Decimal).
#
#   ENCODE:
#
#   We validate the second parameter is a valid decimal integer.
#
#   We normalize the input, and store a sign character ('' for a
#   positive number, '-' for a negative number).
#
#   We then build an array by adding values to the front of the array as
#   we process the input value.  We take the modul0 35 of the input,
#   convert that to 0 through Y, and add it to the front of the array
#   until our input value has become 0.
#
#   We then print the sign value followed by the array elements.
#   
#   DECODE:
#
#   This is similar, although the input string is checked with a regex
#   that ensures that the string, matched case insensitively contains
#   the base 35 characters.
#
#   We normalize the input, converting it to lower case and storing the
#   sign character (if any).
#
#   We then loop over each character in the string.  On each iteration,
#   we multiply an accumulator by 35 and add the character's value to
#   the accumulator (we add 0 through 34 depending on the character).
#
#   We then print the sign and the accumulator.
#
#   USAGE:
#
#   This is self-explanatory and is the usage message for this script.

if (@ARGV != 2) { USAGE(); }
if ($ARGV[0] eq 'encode') {
    encode($ARGV[1]);
} elsif ($ARGV[0] eq 'decode') {
    decode($ARGV[1]);
}

sub encode($input) {
    USAGE() unless $input =~ m/^ \-? [0-9]+ $/sx;

    # Set sign based on input
    my $sign = $input < 0 ? '-' : '';

    # We want an absolute value to start with
    $input = abs($input);

    # Main loop to do the conversion. We stick the output in array @out.
    my @out;
    while ($input) {    # Loop while input > 0
        # Add the digit to the front of the array
        my $digit = $input % 35;
        if ($digit < 10) {
            unshift @out, $digit;
        } else {
            unshift @out, chr($digit - 10 + ord('A'));
        }

        # Move to the next digit in $input
        $input = int($input / 35);
    }

    say $sign . join('', @out);     # Output digits
}

sub decode($input) {
    USAGE() unless $input =~ m/^ \-? [A-Y0-9]+ $/isx;

    # Get sign
    my $sign = ($input =~ m/^ \-/x) ? '-' : '';

    # Remove sign from variable we are parsing & convert to lowercase
    $input =~ s/^ \-//x;
    $input = lc($input);

    # Parse each digit
    my $output = 0;
    foreach my $char (split //, $input) {
        $output *= 35;
        if ($char =~ m/[0-9]/) {
            $output += $char;
        } else {
            # It's not a straight number
            $output += 10 + ord($char) - ord('a'); # Add value of letters
        }
    }

    say $sign . $output;
}

sub USAGE() {
    say STDERR "Usage: ";
    say STDERR "  $0 <op> <num>";
    say STDERR "    <op>  'encode' to convert to Base35 or 'decode' to convert from Base35";
    say STDERR "    <num> A number in the proper format for the operation";
    say STDERR "";
    exit 1;
}


