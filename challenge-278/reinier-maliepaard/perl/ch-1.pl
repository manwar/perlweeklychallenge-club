#!/usr/bin/perl
use strict;
use warnings;

sub sort_string {

    return (join(" ", map { $_ =~ s/\d+//gr }
                      sort( { substr($a, -1, 1) <=> substr($b, -1, 1) }
                      split(/\s+/, $_[0]) ))) ;
};

# TESTS

my $str;

# Example 1
$str = "and2 Raku3 cousins5 Perl1 are4";
print(sort_string($str), "\n"); # Output: "Perl and Raku are cousins"

# Example 2
$str = "guest6 Python1 most4 the3 popular5 is2 language7";
print(sort_string($str), "\n"); # Output: "Python is the most popular guest language"

# Example 3
$str = "Challenge3 The1 Weekly2";
print(sort_string($str), "\n"); # Output: "The Weekly Challenge"
