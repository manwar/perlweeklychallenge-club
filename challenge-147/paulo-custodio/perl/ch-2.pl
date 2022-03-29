#!/usr/bin/env perl

# Challenge 147
#
# TASK #2 › Pentagon Numbers
# Submitted by: Mohammad S Anwar
# Write a script to find the first pair of Pentagon Numbers whose sum and
# difference are also a Pentagon Number.
#
# Pentagon numbers can be defined as P(n) = n(3n - 1)/2.
#
# Example
# The first 10 Pentagon Numbers are:
# 1, 5, 12, 22, 35, 51, 70, 92, 117 and 145.
#
# P(4) + P(7) = 22 + 70 = 92 = P(8)
# but
# P(4) - P(7) = |22 - 70| = 48 is not a Pentagon Number.

use Modern::Perl;
my $limit = 100_000_000;

my @pentagon = (1);
my %is_pentagon;

my($a, $b) = find_pair();
say "($a,$b)";

sub is_pentagon {
    my($num) = @_;
    while ($pentagon[-1] < $num) {
        my $n = scalar(@pentagon)+1;
        my $p = $n*(3*$n - 1)/2;
        push @pentagon, $p;
        $is_pentagon{$p} = 1;
    }
    return $is_pentagon{$num};
}

sub find_pair {
    is_pentagon($limit);        # build pentagon up to N
    my @try = @pentagon;
    for my $a (@try) {
        for my $b (@try) {
            if (is_pentagon($a+$b) && is_pentagon(abs($a-$b))) {
                return ($a, $b);
            }
        }
    }
    die;
}
