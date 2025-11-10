#!/usr/bin/perl

##########################################################################
# You are given a string containing only ( and ).
#
# Write a script to find the length of the longest valid parenthesis.
##########################################################################

use strict;
use warnings;

sub all_longest_valid_parentheses {
    my ($str) = @_;
    my @stack = (-1);
    my $max_len = 0;
    my @results;

    for my $i (0 .. length($str)-1) {
        if (substr($str, $i, 1) eq '(') {
            push @stack, $i;
        } else {
            pop @stack;
            if (@stack) {
                my $len = $i - $stack[-1];
                if ($len > $max_len) {
                    $max_len = $len;
                    @results = ([$stack[-1] + 1, $i]);
                } elsif ($len == $max_len && $len > 0) {
                    push @results, [$stack[-1] + 1, $i];
                }
            } else {
                push @stack, $i;
            }
        }
    }
    return ($max_len, @results);
}

# Example usage:
for my $str ('(()())', ')()())', '((()))()(((()', '))))((()(', '()(()') {
    my ($len, @subs) = all_longest_valid_parentheses($str);

    print "Input: \$str = '$str'\n";
    print "Output: $len\n";
    if ($len > 0) {
        print "Valid Parenthesis: ";
        my @out;
        for my $r (@subs) {
            my ($start, $end) = @$r;
            push @out, "'" . substr($str, $start, $len) . "' at positions $start-$end";
        }
        print join(" and ", @out), ".\n";
    } else {
        print "No valid parenthesis.\n";
    }
    print "\n";
}
