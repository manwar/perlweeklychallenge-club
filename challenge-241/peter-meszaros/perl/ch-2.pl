#!/usr/bin/env perl
#
# You are given an array of unique positive integers greater than 2.
# 
# Write a script to sort them in ascending order of the count of their prime
# factors, tie-breaking by ascending value.
# Example 1
# 
# Input: @int = (11, 8, 27, 4)
# Output: (11, 4, 8, 27))
# 
# Prime factors of 11 => 11
# Prime factors of  4 => 2, 2
# Prime factors of  8 => 2, 2, 2
# Prime factors of 27 => 3, 3, 3
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [11, 8, 27, 4],
    [110, 3, 14, 6],
];

sub prime_order
{
    my $l = shift;

    my %h;
    for my $n (@$l) {
        $h{$n} = grep { $n % $_ == 0 } 2..$n;
    }
    my @res = sort { if ($h{$a} == $h{$b}) {
                        return $a <=> $b;
                     } else {
                        return $h{$a} <=> $h{$b}
                     }
                   } @$l;
	return \@res;
}

is_deeply(prime_order($cases->[0]), [11, 4, 8, 27],  '[11, 8, 27, 4]');
is_deeply(prime_order($cases->[1]), [3, 6, 14, 110], '[110, 3, 14, 6]');
done_testing();

exit 0;
