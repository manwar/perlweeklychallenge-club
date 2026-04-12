#!/usr/bin/perl
use strict;
use warnings;

# In Perl, variables are dynamically typed: a scalar can hold a number or a string
# without explicit declaration. Perl automatically converts the value to the
# type required by the operation being performed.
#
# String context occurs when an operation requires a string, such as:
#   - printing a value
#   - concatenating with another string
#   - applying scalar reverse()
#
# The reverse function behaves differently depending on context:
# - in list context, it reverses the order of list elements
# - in scalar context - as here in scalar reverse($n) - it reverses the characters
#   of its argument

sub palindrome_number {

    my ($n) = @_;
    # Return 1 if the number is a palindrome, 0 otherwise
    return scalar(reverse($n)) eq $n ? 1 : 0;
}

# Tests

my $N;

# Example 1
$N= 1221;
print palindrome_number($N), "\n"; # Output: 1

# Example 2
$N = -101;
print palindrome_number($N), "\n"; # Output: 0

# Example 3
$N = 90;
print palindrome_number($N), "\n"; # Output: 0
