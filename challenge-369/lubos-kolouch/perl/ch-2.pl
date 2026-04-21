#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Test::More;

=head1 NAME

ch-2.pl - Challenge 369 Task 2: Group Division

=head1 SYNOPSIS

Divide a given string into equal-sized groups based on a provided size and filler character.

1. Divide: Split the string into segments of the specified length.
2. Fill: If the final segment does not have enough characters to meet the required size, pad the remaining space with the provided filler character.

=head1 DESCRIPTION

Example 1: "RakuPerl", size 4, filler "*" -> ("Raku", "Perl")
Example 2: "Python", size 5, filler "0" -> ("Pytho", "n0000")
Example 3: "12345", size 3, filler "x" -> ("123", "45x")
Example 4: "HelloWorld", size 3, filler "_" -> ("Hel", "loW", "orl", "d__")

=cut

sub divide_groups {
    my ($str, $size, $filler) = @_;

    return [ $filler x $size ] if $str eq '';

    # Calculate padding
    my $len = length($str);
    my $remainder = $len % $size;
    if ($remainder > 0) {
        $str .= $filler x ($size - $remainder);
    }

    # Split into groups
    my @groups = $str =~ /(.{$size})/g;

    return \@groups;
}

# Unit Tests
is_deeply(divide_groups("RakuPerl", 4, "*"), ["Raku", "Perl"], "Example 1");
is_deeply(divide_groups("Python", 5, "0"), ["Pytho", "n0000"], "Example 2");
is_deeply(divide_groups("12345", 3, "x"), ["123", "45x"], "Example 3");
is_deeply(divide_groups("HelloWorld", 3, "_"), ["Hel", "loW", "orl", "d__"], "Example 4");
is_deeply(divide_groups("AI", 5, "!"), ["AI!!!"], "Example 5");
is_deeply(divide_groups("", 3, "~"), ["~~~"], "Example 6");

done_testing();
