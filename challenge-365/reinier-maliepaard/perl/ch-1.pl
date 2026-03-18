#!/usr/bin/perl
use strict;
use warnings;

# ord('a') is 97 in ASCII.
# To map 'a' -> 1, 'b' -> 2, ..., we subtract (ord('a') - 1)
# i.e. 96, from each letter's ASCII code.
use constant A_ORD => ord('a') - 1;

sub transform {
    my ($s, $k) = @_;

    die "Input must be lowercase letters\n" unless $s =~ /^[a-z]+$/;
    die "k must be positive\n" unless $k =~ /^\d+$/ && $k > 0;

    # letters -> number string
    # $s = "abc" -> 123
    $s = join('', map { ord($_) - A_ORD } split(//, $s));

    # $s = "123"
    # split(//, $s) -> ("1", "2", "3")
    # join('+', ("1", "2", "3")) -> "1+2+3"
    # eval("1+2+3") # Perl now executes this string as code -> 6

    # Safe use of eval: $s contains only digits (0–9), so the constructed
    # expression (e.g. "1+2+3") cannot include arbitrary code. Therefore
    # no code injection is possible in this context.
    $s = eval(join( '+', split(//, $s) )) for 1 .. $k;

    return $s;
}

# Tests

# Example 1
printf "%d\n", transform("abc", 1); # Output: 6

# Example 2
printf "%d\n", transform("az", 2); # Output: 9

# Example 3
printf "%d\n", transform("cat", 1); # Output: 6

# Example 4
printf "%d\n", transform("dog", 2); # Output: 8

# Example 5
printf "%d\n", transform("perl", 3); # Output: 6
