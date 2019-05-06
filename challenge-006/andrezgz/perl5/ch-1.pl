#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-006/
# Challenge #1
# Create a script which takes a list of numbers from command line and print the same in the compact form.
# For example, if you pass "1,2,3,4,9,10,14,15,16" then it should print the compact form like "1-4,9,10,14-16"

use strict;
use warnings;


die "Usage: ch-1.pl <numbers_list>" unless ($ARGV[0]);

# Numbers are sorted in ascending order just in case
my @numbers = sort {$a <=> $b} split ',', $ARGV[0];

my ($first, $last) = (shift @numbers) x 2;

foreach my $n (@numbers){
    if ($n - $last > 1) {
        print compact_term($first, $last).',';
        $first = $n;
    }
    $last = $n;
}

print compact_term($first, $last).$/;

# Returns a term for the compact form: a single number, two numbers (m,n) or a range (m-n)
sub compact_term {
    my ($first, $last) = @_;
    my $separator = ($last - $first == 1) ? ',' : '-';
    return ($last == $first) ? $first : $first.$separator.$last;
}
