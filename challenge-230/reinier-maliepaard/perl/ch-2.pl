#!/usr/bin/perl
use strict;
use warnings;

sub count_words {
    my ($prefix, $ref_words) = @_;

    return scalar grep { /^\Q$prefix\E/ } @$ref_words; # \Q...\E treats prefix as literal string
}

# Tests

my @words;
my $prefix;

# Example 1
@words = qw(pay attention practice attend);
$prefix = "at";
print count_words($prefix, \@words), "\n"; # Output: 2

# Example 2
@words = qw(janet julia java javascript);
$prefix = "ja";
print count_words($prefix, \@words), "\n"; # Output: 3
