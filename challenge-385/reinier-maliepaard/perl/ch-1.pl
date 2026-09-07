#!/usr/bin/perl
use strict;
use warnings;

# Return all uncommon words (words that appear exactly once across both sentences).
sub unique {
    my ($s1, $s2) = @_;

    my %count;
    my @words = split / /, "$s1 $s2";

    # Count the occurrences of each word.
    $count{$_}++ for @words;

    # Return words that occur exactly once, preserving their order.
    return grep { $count{$_} == 1 } @words;
}

# Print the result in the required format.
sub print_result {
    my (@words) = @_;

    print "(",
          join(", ", map { qq("$_") } @words),
          ")\n";
}

# TESTS

my ($s1, $s2);

# Example 1
my $s1 = "apple banana apple";
my $s2 = "banana orange";
print_result( unique($s1, $s2) );  # ("orange")

# Example 2
$s1 = "cat dog";
$s2 = "bird fish";
print_result( unique($s1, $s2) );  # ("cat", "dog", "bird", "fish")

# Example 3
$s1 = "the quick brown fox";
$s2 = "the quick";
print_result( unique($s1, $s2) );  # ("brown", "fox")

# Example 4
$s1 = "hello";
$s2 = "hello";
print_result( unique($s1, $s2) );  # ()

# Example 5
$s1 = "blue blue red";
$s2 = "red green green yellow";
print_result( unique($s1, $s2) );  # ("yellow")
