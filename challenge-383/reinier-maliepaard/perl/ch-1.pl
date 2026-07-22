#!/usr/bin/perl
use strict;
use warnings;

This challenge was, for me, a bit unclear and ambiguous. The following
remarks explain my interpretation of the specification before presenting
my solution.

For clarity, I interpret the challenge as follows:
You are given three lists. The first two are lists of strings. The third
is a list of similarity groups, where each group contains strings that are
considered equivalent. Determine whether the first two lists are similar.

Two lists are considered similar if:
1. They have the same length and
2. each pair of corresponding words is either identical, or
3. the two words belong to the same similarity group.

For the purpose of this solution, I assume that list1 and list2 normally
contain two elements, and that list3 contains one or two similarity groups.

Perl note:
The notation in the specification should be interpreted as a description
of the data rather than as literal Perl syntax. In particular, using Perl
variable names such as $list1 together with non-Perl list assignment syntax
may be misleading.

Since the input consists of lists, and especially a list of lists, the
most natural Perl representation is through array references:

    my $list1 = ["great", "acting"];
    my $list2 = ["fine", "drama"];
    my $list3 = [
        ["great", "fine"],
        ["acting", "drama"]
    ];

Here, $list1 and $list2 are references to arrays containing strings, while
$list3 is a reference to an array of similarity groups. This representation
clearly distinguishes between Perl lists, arrays, and references, and
reflects how the data would normally be handled in Perl.

sub similar_lists {

    my ($l1, $l2, $l3) = @_;

    # Lists must have the same number of elements.
    return 0 if @$l1 != @$l2;

    # Both words are identical.
    return 1 if $l1->[0] eq $l2->[0]
             && $l1->[1] eq $l2->[1];

    my ($x, $y);

    # Find the only pair of words that still needs comparing.
    if ($l1->[0] eq $l2->[0]) {
        ($x, $y) = ($l1->[1], $l2->[1]);
    }
    else {
        ($x, $y) = ($l1->[0], $l2->[0]);
    }

    # Check each similarity group.
    for my $group (@$l3) {

        # Create a hash for fast lookup.
        my %seen = map { $_ => 1 } @$group;

        # Found both words in the same group.
        return 1 if exists $seen{$x}
                 && exists $seen{$y};
    }

    # No matching similarity group found.
    return 0;
}

sub print_result {
    print $_[0] ? "true\n" : "false\n";
}

# Tests

my ($list1, $list2, $list3);

# Example 1
$list1 = ["great", "acting"];
$list2 = ["fine", "drama"];
$list3 = [
    ["great", "fine"],
    ["acting", "drama"]
];
print_result(similar_lists($list1, $list2, $list3)); # Output: true

# Example 2
$list1 = ["apple", "pie"];
$list2 = ["banana", "pie"];
$list3 = [
    ["apple", "peach"],
    ["peach", "banana"]
];
print_result(similar_lists($list1, $list2, $list3)); # Output: false

# Example 3
$list1 = ["perl4", "python"];
$list2 = ["raku", "python"];
$list3 = [
    ["perl4", "perl5", "raku"]
];
print_result(similar_lists($list1, $list2, $list3)); # Output: true

# Example 4
$list1 = ["enjoy", "challenge"];
$list2 = ["love", "weekly", "challenge"];
$list3 = [
    ["enjoy", "love"]
];
print_result(similar_lists($list1, $list2, $list3)); # Output: false

# Example 5
$list1 = ["fast", "car"];
$list2 = ["quick", "vehicle"];
$list3 = [
    ["quick", "fast"],
    ["vehicle", "car"]
];
print_result(similar_lists($list1, $list2, $list3)); # Output: true
