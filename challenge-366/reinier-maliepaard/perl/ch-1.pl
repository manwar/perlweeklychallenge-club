#!/usr/bin/perl
use strict;
use warnings;

sub count_prefixes {
    my ($arr, $str) = @_;
    my $count = 0;

    # Store a computed value in a variable so you don’t recompute it
    # For large arrays (e.g. 100k+ elements, tight loops), you may get measurable speed improvements.

    for my $prefix (@$arr) {
        # empty string is technically a prefix
        # the next line not necessary:
        # next if $prefix eq '';

        my $len = length($prefix);
        # a longer string can never be a prefix:
        next if $len > length($str);

        $count++ if $prefix eq substr($str, 0, $len);
    }

    return $count;
}

# Tests

my @arr;
my $str;

# Example 1
@arr = ("a", "ap", "app", "apple", "banana");
$str = "apple";
printf "%d\n", count_prefixes(\@arr, $str); # Output: 4

# Example 2
@arr = ("cat", "dog", "fish");
$str = "bird";
printf "%d\n", count_prefixes(\@arr, $str); # Output:  0

# Example 3
@arr = ("hello", "he", "hell", "heaven", "he");
$str = "hello";
printf "%d\n", count_prefixes(\@arr, $str); # Output: 4

# Example 4
@arr = ("", "code", "coding", "cod");
$str = "coding";
printf "%d\n", count_prefixes(\@arr, $str); # Output: 3

# Example 5
@arr = ("p", "pr", "pro", "prog", "progr", "progra", "program");
$str = "program";
printf "%d\n", count_prefixes(\@arr, $str); # Output: 7
