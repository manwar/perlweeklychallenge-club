#!/usr/bin/perl
use strict;
use warnings;

sub rearrange_spaces {
    my ($str) = @_;

    die "Input must be a non-empty string containing at least one space!\n"
        unless defined $str && $str =~ /\S/ && $str =~ / /;

    my $num_spaces = ($str =~ tr/ //);
    my @words      = ($str =~ /([\w'-]+)/g);
    my $word_count = scalar @words;

    if ($word_count < 2) {
        return '"' . $words[0] . (' ' x $num_spaces) . '"';
    }

    my $gap       = int($num_spaces / ($word_count - 1));
    my $remainder = $num_spaces - $gap * ($word_count - 1);

    return '"' . join(' ' x $gap, @words) . (' ' x $remainder) . '"';
}

# Tests

my $str;

# Example 1
$str = "  challenge  ";
print rearrange_spaces($str), "\n"; # Output: "challenge    "

# Example 2
$str = "coding  is  fun";
print rearrange_spaces($str), "\n"; # Output: "coding  is  fun"

# Example 3
$str = "a b c  d";
print rearrange_spaces($str), "\n"; # Output: "a b c d "

# Example 4
$str = "  team      pwc  ";
print rearrange_spaces($str), "\n"; # Output: "team          pwc"

# Example 5
$str = "   the  weekly  challenge  ";
print rearrange_spaces($str), "\n"; # Output: "the    weekly    challenge "
