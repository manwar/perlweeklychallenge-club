#!/usr/bin/env perl

# Challenge 146
#
# Consider the following Curious Fraction Tree:
#
#
# Curious Fraction Tree
#
#
# You are given a fraction, member of the tree created similar to the above sample.
#
# Write a script to find out the parent and grandparent of the given member.
#
# Example 1:
#     Input: $member = '3/5';
#     Output: parent = '3/2' and grandparent = '1/2'
# Example 2:
#     Input: $member = '4/3';
#     Output: parent = '1/3' and grandparent = '1/2'
#
# Solution:
# for node a/b, the children are a/(a+b) and (a+b)/b

use Modern::Perl;

my($a, $b) = split(/\//, shift);
print "$a/$b -> ";
($a, $b) = parent($a, $b);
print "$a/$b -> ";
($a, $b) = parent($a, $b);
print "$a/$b\n";


sub parent {
    my($a, $b) = @_;
    my($parent_a, $parent_b);
    if ($a/$b < 1) {    # a/(a+b)
        $parent_a = $a;
        $parent_b = abs($b-$a);
    }
    else {              # (a+b)/b
        $parent_a = abs($b-$a);
        $parent_b = $b;
    }
    return ($parent_a, $parent_b);
}
