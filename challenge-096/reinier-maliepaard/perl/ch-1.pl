#!/usr/bin/perl
use strict;
use warnings;

# Two solutions:
# reverse_words_alt is more idiomatic Perl and simpler, but reverse_words
# gives you more control if you wanted to preserve some spacing or handle
# edge cases differently.

sub reverse_words {

    my ($str) = @_;
    # remove leading and trailing spaces
    $str =~ s/(^\s+|\s+$)//g;
    # multiple spaces to one space
    $str =~ s/\h+/ /g;

    return reverse split / /, $str;
}

sub reverse_words_alt {

    my ($str) = @_;
    # $str =~ /\S+/g — finds all non-space sequences (words) directly.
    return reverse $str =~ /\S+/g;
}

# Tests
my $str;

# Example 1
$str = "Perl Weekly Challenge";
print join ' ', reverse_words($str), "\n"; # Output: Challenge Weekly Perl
print join ' ', reverse_words_alt($str), "\n"; # Output: Challenge Weekly Perl

# Example 2
$str = "    Perl and   Raku are  part of the same family  ";
print join ' ', reverse_words($str), "\n"; # Output: family same the of part are Raku and Perl
print join ' ', reverse_words_alt($str), "\n"; # Output: family same the of part are Raku and Perl
