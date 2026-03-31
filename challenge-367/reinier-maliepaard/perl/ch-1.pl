#!/usr/bin/perl
use strict;
use warnings;

# Function to return the maximum odd binary string
sub max_odd_binary {

    # We want to rearrange a binary string (e.g. "01011") to form
    # the largest possible odd binary number.
    #
    # - 'Odd'     -> the string must end in '1'
    # - 'Largest' -> place as many '1's as possible at the front
    #
    # You can think of this rearrangement as constructing a new string by:
    # - first appending (count_ones - 1) times '1'
    # - then appending all '0's
    # - and finally appending one last '1'

    # Edge case: if there is only one '1',
    # the result will be all '0's followed by a single '1',
    # which may include leading zeros (this is allowed).

    # Input binary string
    my ($bin) = @_;

    # --------------------------------------
    # Defensive checks
    # --------------------------------------

    # Check: input defined and non-empty
    die "Input must be a non-empty string\n"
        unless defined $bin && length $bin;

    # Check: only '0' and '1' allowed
    die "Input must contain only '0' and '1'\n"
        unless $bin =~ /^[01]+$/;

    # Check: at least one '1' (required to make result odd)
    die "Input must contain at least one '1'\n"
        unless $bin =~ /1/;

    # Count the number of ones
    # --------------------------------------
    # Option 1: Safe way using split + grep
    # --------------------------------------
    my $count_ones = scalar grep { $_ eq '1' } split //, $bin;

    # Note: 'scalar' is redundant: grep returns the count in scalar context

    # --------------------------------------
    # Option 2: Using tr/// (Perl shortcut)
    # --------------------------------------
    # my $count_ones = ($bin =~ tr/1//);
    # This counts the number of '1's.
    # NOTE: tr/1// does NOT modify $bin (no replacement part).
    # Want to be extra safe or explicit?
    # Use: my $count_ones = ($bin =~ tr/1/1/);
    # This also returns the count, but performs a substitution
    # (each '1' is replaced by '1'), so $bin is technically modified
    # even though its content remains unchanged.

    # Count the number of zeros
    my $count_zeros = length($bin) - $count_ones;

    # Build the maximum odd binary:
    # 1. Place (ones - 1) '1's at the front
    # 2. Place all zeros
    # 3. Place final '1' to make it odd
    my $result = ('1' x ($count_ones - 1)) . ('0' x $count_zeros) . '1';

    return $result;
}

# Tests

my $str;

# Example 1
$str = "1011";
printf "%s\n", max_odd_binary($str); # Output: "1101"

# Example 2
$str = "100";
printf "%s\n", max_odd_binary($str); # Output: "001"

# Example 3
$str = "111000";
printf "%s\n", max_odd_binary($str); # Output: "110001"

# Example 4
$str = "0101";
printf "%s\n", max_odd_binary($str); # Output: "1001"

# Example 5
$str = "1111";
printf "%s\n", max_odd_binary($str); # Output: "1111"
