#!/usr/bin/perl
use strict;
use warnings;

# Some didactical hints:

Function caesar_cipher($str, $dist)

# Performs Caesar cipher shift on Roman alphabet text (A-Z, a-Z only).
# - Validates input contains ONLY ASCII letters (rejects spaces, digits, punctuation, accented chars, Greek/Cyrillic, etc.)
# - Shifts each letter by $distance positions, wrapping z→a and Z→A
# - Normalizes large distances (e.g. 27 ≡ 1)
# - Dies with error message on invalid input

# Explanation: chr( (ord($_) - ord('a') + $dist) % 26 + ord('a') )

# ord($_): ASCII code of input char (e.g. 'x' -> 120)
# ord('a'):  position in alphabet (120 - 97 = 23)
# + $dist: add shift (23 + 1 = 24)
# % 26: wrap around alphabet (24 % 26 = 24)
# + ord('a'): back to ASCII (24 + 97 = 121)
# chr(...): character from ASCII code (121 ->'y')

# Note: the challenge says "for each character in the string", which usually implies
# leave non-letters unchanged. My solution instead rejects them.

sub caesar_cipher {
    my ($str, $dist) = @_;

    die "Input must be A–Z or a–z only\n" unless defined $str && $str =~ /\A[a-zA-Z]+\z/;

    # Normalize large distances
    $dist %= 26;

    my $new_str = join '', map {
        if ($_ ge 'a' && $_ le 'z') {
            chr( (ord($_) - ord('a') + $dist) % 26 + ord('a') );
        } else {  # A–Z
            chr( (ord($_) - ord('A') + $dist) % 26 + ord('A') );
        }
    } split //, $str;

    return $new_str;
}


# Tests
my ($str, $dist);

# Example 1
$str = "abc";
$dist = 1;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: bcd

# Example 2
$str = "xyz";
$dist = 2;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: "zab"

# Example 3
$str = "abc";
$dist = 27;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: "bcd"

# Example 4
$str = "hello";
$dist = 5;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: "mjqqt"

# Example 5
$str = "perl";
$dist = 26;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: "perl"

# Example 6
$str = "AbCdEf";
$dist = 1;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: "BcDeFg"

# Example 7
$str = "xyzXYZ";
$dist = 3;
print "$str is encrypted as " . caesar_cipher($str, $dist) .  "\n";  # Output: "abcABC"
