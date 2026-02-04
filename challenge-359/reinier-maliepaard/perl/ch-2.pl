#!/usr/bin/perl
use strict;
use warnings;

# Some didactical hints:

# Again I choose for substr, Why?
# substr is underrated in Perl, but it's actually super
# fast because it manipulates the string in place instead of copying arrays
# or building lots of temporary strings. It's perfect for this kind of
# "adjacent duplicate removal" algorithm.

# Why $out + substr is a great choice:

# Single-pass, efficient
# - You never rescan the string multiple times (unlike the regex loop).
# - Each character is read once, and removals happen in place.

# Low memory overhead
# - No arrays, no push/pop - just one string you manipulate.

# Easy to read once you understand substr($out, -1, 1, '')
# - Last character removal is clear and explicit.
# - Appending with .= is intuitive.

# Perfect for large strings
# - Regex repeated scans can be slower for long strings.
# - Stack array works fine but may have more memory churn.

sub remove_adjacent_duplicates {
    my ($s) = @_;
    my $out = '';
    for my $ch (split //, $s) {
        if (length($out) && substr($out, -1, 1) eq $ch) {
            substr($out, -1, 1, '');
        } else {
            $out .= $ch;
        }
    }
    return $out;
}

# Tests

my $word;

$word = "aabbccdd";
printf "%s\n", remove_adjacent_duplicates($word); # ""

$word = "abccba";
printf "%s\n", remove_adjacent_duplicates($word); # ""

$word = "abcdef";
printf "%s\n", remove_adjacent_duplicates($word); # "abcdef"

$word = "aabbaeaccdd";
printf "%s\n", remove_adjacent_duplicates($word); # "aea"

$word = "mississippi";
printf "%s\n", remove_adjacent_duplicates($word); # "m"
