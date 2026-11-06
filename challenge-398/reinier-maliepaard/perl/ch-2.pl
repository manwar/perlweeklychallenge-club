#!/usr/bin/perl
use strict;
use warnings;

sub string_difference {

    my @words = @_;
    my @result;

    for my $word (@words) {

        my @differences;

        for my $i (0 .. length($word) - 2) {

            my $first  = ord(substr($word, $i, 1));
            my $second = ord(substr($word, $i + 1, 1));

            push @differences, $second - $first;
        }

        # Convert the complete difference array into a string.
        # join(',', ...) separates the values with commas.
        # For example: [2, 2, 2] becomes "2,2,2".
        #
        # This is important: we want to compare complete difference
        # sequences, not individual differences.
        push @result, join(',', @differences);
    }

    # Count how often each complete difference sequence occurs.
    # The hash key is the difference sequence;
    # the hash value is its number of occurrences.
    my %count;
    $count{$_}++ for @result;

    # Find the index of the difference sequence that occurs only once.
    #
    # grep returns a list. Since exactly one sequence is unique,
    # we assign that single index to $index.
    my ($index) = grep { $count{$result[$_]} == 1 } 0 .. $#result;

    return $words[$index];
}

#  Tests

my @words;

# Example 1
@words = ("ab", "bc", "cd", "zy");
print "Result ex. 1: ", string_difference(@words), "\n"; # Output: "zy"

# Example 2
@words = ("cba", "fed", "azy");
print "Result ex. 2: ", string_difference(@words), "\n"; # Output: "azy"

# Example 3
@words = ("pop", "ada", "beb", "cfc");
print "Result ex. 3: ", string_difference(@words), "\n"; # Output: "pop"

# Example 4
@words = ("aaaa", "zzzz", "mmmm", "aaba");
print "Result ex. 4: ", string_difference(@words), "\n"; # Output: "aaba"

# Example 5
@words = ("aceg", "bdfh", "cegi", "azbz");
print "Result ex. 5: ", string_difference(@words), "\n"; # Output: "azbz"

# Example 6
@words = ("acegik", "bdfhjl", "cegikm", "azbycx");
print "Result ex. 6: ", string_difference(@words), "\n"; # Output: "azbycx"

# Example 7
@words = ("acegikm", "bdfhjln", "cegikmo", "azbycxd");
print "Result ex. 7: ", string_difference(@words), "\n"; # Output: "azbycxd"

# Example 8
@words = ("acegikmo", "bdfhjlnp", "cegikmoq", "azbycxdw");
print "Result ex. 8: ", string_difference(@words), "\n"; # Output: "azbycxdw"

# Example 9
@words = ("abd", "abd", "abd", "acd");
print "Result ex. 9: ", string_difference(@words), "\n"; # Output: "acd"
