#!/usr/bin/perl
use strict;
use warnings;

sub split_strings {
    my ($separator, $words) = @_;
    my @res;
    my $re = qr/\Q$separator\E/;
    for (@$words) {
        push (@res, split /$re/, $_);
    }
    return @res;
}

# alternative

sub split_strings_alt {
    my ($separator, $words) = @_;
    my $re = qr/\Q$separator\E/;
    return grep { length }
           map  { split $re, $_ } @$words;
}

# Tests

my (@words, $separator);

# Example 1a
@words = ("one.two.three","four.five","six");
$separator = "\.";
my @result1 = split_strings($separator, \@words);
print '"' . join('","', @result1) . '"' . "\n"; # Output: "one","two","three","four","five","six"

# Example 2a
@words = ("\$perl\$\$", "\$\$raku\$");
$separator = "\\$";
my @result2 = split_strings($separator, \@words);
@result2 = grep { $_ ne '' } @result2; # Remove empty strings
print '"' . join('","', @result2) . '"' . "\n"; # Output: "per","raku"

# Example 1b
@words = ("one.two.three", "four.five", "six");
$separator = '.';
my @result1 = split_strings_alt($separator, \@words);
#print '"' . join('","', @result1) . '"' . "\n";
print '"' . join('","', split_strings_alt($separator, \@words)) . '"' . "\n"; # Output: "one","two","three","four","five","six"

# Example 2b
@words = ('$perl$$', '$$raku$');
$separator = '$';
my @result2 = split_strings_alt($separator, \@words);
print '"' . join('","', split_strings_alt($separator, \@words)) . '"' . "\n"; # Output: "perl","raku"
