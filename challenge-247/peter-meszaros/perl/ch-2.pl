#!/usr/bin/env perl
#
# You are given a string S of lower case letters 'a'..'z'.
# 
# Write a script that finds the pair of consecutive letters in S that appears
# most frequently. If there is more than one such pair, chose the one that is the
# lexicographically first.
# Example 1
# 
# Input: $s = 'abcdbca'
# Output: 'bc'
# 
# 'bc' appears twice in `$s`
# 
# Example 2
# 
# Input: $s = 'cdeabeabfcdfabgcd'
# Output: 'ab'
# 
# 'ab' and 'cd' both appear three times in $s and 'ab' is lexicographically
# smaller than 'cd'.
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	'abcdbca',
	'cdeabeabfcdfabgcd',
];

sub most_frequent_pair
{
    my $s = shift;

    my @s = split('', $s);
    my %h;
    for my $l (0..($#s-1)) {
        $h{$s[$l].$s[$l+1]}++;
    }
    return (sort {$h{$b} == $h{$a} ? 
					$a cmp $b :
                    $h{$b} <=> $h{$a}
				 } keys %h)[0];
}

is(most_frequent_pair($cases->[0]),  'bc', 'abcdbca');
is(most_frequent_pair($cases->[1]),  'ab', 'cdeabeabfcdfabgcd');
done_testing();

exit 0;

         
