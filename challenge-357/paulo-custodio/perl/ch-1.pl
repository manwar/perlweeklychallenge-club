#!/usr/bin/env perl

# Challenge 357
#
# Task 1: Kaprekar Constant
# Submitted by: Mohammad Sajid Anwar
# Write a function that takes a 4-digit integer and returns how many iterations are required to reach Kaprekar’s constant (6174). For more information about Kaprekar's Constant please follow the wikipedia page.
#
# Example 1
# Input: $int = 3524
# Output: 3
#
# Iteration 1: 5432 - 2345 = 3087
# Iteration 2: 8730 - 0378 = 8352
# Iteration 3: 8532 - 2358 = 6174
#
# Example 2
# Input: $int = 6174
# Output: 0
#
# Example 3
# Input: $int = 9998
# Output: 5
#
# Iteration 1: 9998 - 8999 = 0999
# Iteration 2: 9990 - 0999 = 8991
# Iteration 3: 9981 - 1899 = 8082
# Iteration 4: 8820 - 0288 = 8532
# Iteration 5: 8532 - 2358 = 6174
#
# Example 4
# Input: $int = 1001
# Output: 4
#
# Iteration 1: 1100 - 0011 = 1089
# Iteration 2: 9810 - 0189 = 9621
# Iteration 3: 9621 - 1269 = 8352
# Iteration 4: 8532 - 2358 = 6174
#
# Example 5
# Input: $int = 9000
# Output: 4
#
# Iteration 1: 9000 - 0009 = 8991
# Iteration 2: 9981 - 1899 = 8082
# Iteration 3: 8820 - 0288 = 8532
# Iteration 4: 8532 - 2358 = 6174
#
# Example 6
# Input: $int = 1111
# Output: -1
#
# The sequence does not converge on 6174, so return -1.

use Modern::Perl;

@ARGV==1 or die "usage: $0 num\n";
say num_steps($ARGV[0]);

sub num_steps {
    my($num) = @_;
    return -1 if length($num) != 4;
    my $steps = 0;
    my %seen;
    while ($num != 6174) {
        my $n1 = join '', sort split //, $num;
        $n1 = "0" x (4 - length($n1)) . $n1;
        my $n2 = join '', reverse sort split //, $num;
        $n2 .= "0" x (4 - length($n2));
        ($n1, $n2) = sort {$a<=>$b} ($n1, $n2);
        $num = $n2-$n1;
        $steps++;
        return -1 if $seen{$num}++;
    }
    return $steps;
}
