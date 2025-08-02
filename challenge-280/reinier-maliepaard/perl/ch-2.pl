#!/usr/bin/perl
use strict;
use warnings;

sub count_asterisks {

    # Remove the content within each pair of vertical bars
    $_[0] =~ s/\|[^|]*\|//g;

    # Count the remaining asterisks
    # see 11.3 on https://reiniermaliepaard.nl/perl/part-1/index.php?id=transliteration
    return( $_[0] =~ tr/*/*/ );
}

# Tests

my $str;

# Example 1
$str = "p|*e*rl|w**e|*ekly|";
print(count_asterisks($str), "\n"); # Output: 2

# Example 2
$str = "perl";
print(count_asterisks($str), "\n"); # Output: 0

# Example 3
$str = "th|ewe|e**|k|l***ych|alleng|e";
print(count_asterisks($str), "\n"); # Output: 5
