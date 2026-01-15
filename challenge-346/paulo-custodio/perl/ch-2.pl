#!/usr/bin/env perl

# Challenge 346
#
# Task 2: Magic Expression
# Submitted by: Mohammad Sajid Anwar
# You are given a string containing only digits and a target integer.
#
# Write a script to insert binary operators +, - and * between the digits in the given string that evaluates to target integer.
#
#
# Example 1
# Input: $str = "123", $target = 6
# Output: ("1*2*3", "1+2+3")
#
# Example 2
# Input: $str = "105", $target = 5
# Output: ("1*0+5", "10-5")
#
# Example 3
# Input: $str = "232", $target = 8
# Output: ("2*3+2", "2+3*2")
#
# Example 4
# Input: $str = "1234", $target = 10
# Output: ("1*2*3+4", "1+2+3+4")
#
# Example 5
# Input: $str = "1001", $target = 2
# Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")

use Modern::Perl;

# List of operators to inject
my @operators = ('+', '-', '*');

@ARGV==2 or die "usage: $0 digits target\n";
my($digits, $target) = @ARGV;

my @all_expr = generate_expressions($digits);
my @result = grep { eval($_) == $target } @all_expr;
say join ", ", sort @result;


sub generate_expressions {
    my($string) = @_;
    my @results;

    # Internal helper for backtracking partitions
    my $backtrack;
    $backtrack = sub {
        my($remaining, $current_parts) = @_;

        # Base case: string fully partitioned
        if (length($remaining) == 0) {
            # For this specific partition, generate all operator combos
            push @results, combine_with_operators($current_parts);
            return;
        }

        for my $len (1 .. length($remaining)) {
            # skip parts with leading zeros
            my $next_part = substr($remaining, 0, $len);
            next if $next_part =~ /^0\d+/;

            # try with this substring and next part
            push @$current_parts, $next_part;
            $backtrack->(substr($remaining, $len), $current_parts);
            pop @$current_parts; # Backtrack
        }
    };

    $backtrack->($string, []);
    return @results;
}

# Helper to inject operators (+, -, *) between partition elements
sub combine_with_operators {
    my ($parts) = @_;
    return $parts->[0] if @$parts == 1; # No gaps if only one part

    my @expressions = ($parts->[0]);

    # For each subsequent part, multiply existing expressions by all 3 operators
    for my $i (1 .. $#$parts) {
        my @next_gen;
        for my $expr (@expressions) {
            for my $op (@operators) {
                push @next_gen, $expr . $op . $parts->[$i];
            }
        }
        @expressions = @next_gen;
    }

    return @expressions;
}
