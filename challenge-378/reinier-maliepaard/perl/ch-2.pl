#!/usr/bin/perl
use strict;
use warnings;

# # There are two equivalent approaches using transliteration (tr///):
# 1. one applies it directly to each string,
# 2. the other applies it in a loop using $_.

# Solution 1
# sub is_sum_of_words_equal  {
#     my ($a, $b, $c) = @_;
#
#     $a =~ tr/a-j/0-9/;
#     $b =~ tr/a-j/0-9/;
#     $c =~ tr/a-j/0-9/;
#
#     return $a + $b == $c;
# }
#
# Solution 2
# - Perl iterates over @str one element at a time
# - during each iteration, $_ becomes an alias to the current element
# - tr/// modifies $_ in place
# - because $_ is an alias, the corresponding element in @str is modified too

sub is_sum_of_words_equal {
    my @str = @_;

    $_ =~ tr/a-j/0-9/ for @str;

    # After the loop:
    # the elements of @str have been modified in place:
    # e.g. ("acb","cba","cdb") -> ("021","210","231")

    # Perl automatically converts strings to numbers here
    return  $str[0] + $str[1] == $str[2];
}

# Tests

my ($str1, $str2, $str3);

# Example 1
$str1 = "acb";
$str2 = "cba";
$str3 = "cdb";
print is_sum_of_words_equal($str1, $str2, $str3) ? "true\n" : "false\n"; # Output: true

# Example 2
$str1 = "aab";
$str2 = "aac";
$str3 = "ad";
print is_sum_of_words_equal($str1, $str2, $str3) ? "true\n" : "false\n"; # Output: true

# Example 3
$str1 = "bc";
$str2 = "je";
$str3 = "jg";
print is_sum_of_words_equal($str1, $str2, $str3) ? "true\n" : "false\n"; # Output: false

# Example 4
$str1 = "a";
$str2 = "aaaa";
$str3 = "aa";
print is_sum_of_words_equal($str1, $str2, $str3) ? "true\n" : "false\n"; # Output: true

# Example 5
$str1 = "c";
$str2 = "d";
$str3 = "h";
print is_sum_of_words_equal($str1, $str2, $str3) ? "true\n" : "false\n"; # Output: false

# Example 6
$str1 = "gfi";
$str2 = "hbf";
$str3 = "bdhd";
print is_sum_of_words_equal($str1, $str2, $str3) ? "true\n" : "false\n"; # Output: true
