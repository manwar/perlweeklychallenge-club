#!/usr/bin/env perl

# Challenge 115
#
# TASK #1 - String Chain
# Submitted by: Mohammad S Anwar
# You are given an array of strings.
#
# Write a script to find out if the given strings can be chained to form a
# circle. Print 1 if found otherwise 0.
#
# A string $S can be put before another string $T in circle if the last
# character of $S is same as first character of $T.
#
# Examples:
# Input: @S = ("abc", "dea", "cd")
# Output: 1 as we can form circle e.g. "abc", "cd", "dea".
#
# Input: @S = ("ade", "cbd", "fgh")
# Output: 0 as we can't form circle.

use Modern::Perl;

my @words = @ARGV;
@words or die "Usage: ch-1.pl words...\n";

say is_circle(\@words) ? 1 : 0;

sub is_circle {
    my($pending, @words) = @_;
    my $found_solution;

    if (@$pending == 0) {
        $found_solution ||= substr($words[-1],-1,1) eq substr($words[0],0,1);
    }
    else {
        for my $word (@$pending) {
            if (@words == 0 ||
                substr($words[-1],-1,1) eq substr($word,0,1)) {
                my @new_pending = grep {$_ ne $word} @$pending;
                $found_solution ||= is_circle(\@new_pending, @words, $word);
            }
        }
    }
    return $found_solution;
}
