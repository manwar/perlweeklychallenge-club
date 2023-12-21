#!/usr/bin/env perl
#
# You are given a string and a character in the given string.
# 
# Write a script to return an array of integers of size same as length of the
# given string such that:
# 
# distance[i] is the distance from index i to the closest occurence of
# the given character in the given string.
# 
# The distance between two indices i and j is abs(i - j).
# 
# Example 1
# 
# Input: $str = "loveleetcode", $char = "e"
# Output: (3,2,1,0,1,0,0,1,2,2,1,0)
# 
# The character 'e' appears at indices 3, 5, 6, and 11 (0-indexed).
# The closest occurrence of 'e' for index 0 is at index 3, so the distance is abs(0 - 3) = 3.
# The closest occurrence of 'e' for index 1 is at index 3, so the distance is abs(1 - 3) = 2.
# For index 4, there is a tie between the 'e' at index 3 and the 'e' at index 5,
# but the distance is still the same: abs(4 - 3) == abs(4 - 5) = 1.
# The closest occurrence of 'e' for index 8 is at index 6, so the distance is abs(8 - 6) = 2.
# 
# Example 2
# 
# Input: $str = "aaab", $char = "b"
# Output: (3,2,1,0)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[ "loveleetcode", "e"],
	[ "aaab",         "b"],
];

sub shortest_distance
{
	sub get_pos
	{
		my $pos = shift;
		my $n   = shift;

		my @res;
		for (0..$#$pos) {
			if ($_ == 0 && $n < $pos->[$_]) { # smaller than zeroth item
                @res = (undef, $pos->[$_]);
                last;
            } elsif ($_ == $#$pos && $n > $pos->[$_]) { # bigger than last item
                @res = ($pos->[$_], undef);
                last;
            } elsif ($n < $pos->[$_] && $n > $pos->[$_-1]) {
                @res = ($pos->[$_-1], $pos->[$_]);
                last;
            }
		}
		return @res;
	}

	my $str = $_[0]->[0];
	my $chr = $_[0]->[1];

	my @str = split('', $str);

	# get chr positions
	my @pos;
	for (0..$#str) {
		push @pos, $_ if $str[$_] eq $chr;
	}
	@pos = sort {$a <=> $b} @pos;

	my @ret;
	for my $n (0..$#str) {
		my $d = 0;
	
        # calculate distances
		if ($str[$n] ne $chr) {
			my @p = get_pos(\@pos, $n);

            if (defined $p[0]) {
                $d = abs($p[0] - $n);
            }
            if (defined $p[1]) {
                my $d2 = abs($p[1] - $n);
                $d = $d2 if $d == 0 or $d2 < $d;
            }
		}
        push @ret, $d;
	}

	return \@ret;
}

is_deeply(shortest_distance($cases->[0]), [3,2,1,0,1,0,0,1,2,2,1,0], '[ "loveleetcode", "e"]');
is_deeply(shortest_distance($cases->[1]), [3,2,1,0],                 '[ "aaab",         "b"]');
done_testing();

exit 0;
