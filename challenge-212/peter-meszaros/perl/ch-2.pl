#!/usr//bin/perl
# Example 1:
# 
# Input: @list = (1,2,3,5,1,2,7,6,3) and $size = 3
# Output: (1,2,3), (1,2,3), (5,6,7)
# 
# Example 2:
# 
# Input: @list = (1,2,3) and $size = 2
# Output: -1
# 
# Example 3:
# 
# Input: @list = (1,2,4,3,5,3) and $size = 3
# Output: (1,2,3), (3,4,5)
# 
# Example 4:
# 
# Input: @list = (1,5,2,6,4,7) and $size = 3
# Output: -1

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use List::MoreUtils qw/frequency/;

my $cases = [
	[[1,2,3,5,1,2,7,6,3], 3],
	[[1,2,3],             2],
	[[1,2,4,3,5,3],       3],
	[[1,5,2,6,4,7],       3],
];

sub rearrange_groups
{
	my ($list, $size) = @_;

    return -1 if @$list % $size;
	my $l = @$list / $size;

    my @s = sort {$a <=> $b} @$list;

    my $res = [];
    push @$res, [] for 1..$l;
    
    for my $i (@s) {
        my $added = 0;
		for my $j (0..($l-1)) {
            my $prev = $res->[$j]->[-1];
			next if $res->[$j]->@* >= $size;
			if ((not defined $prev) or ($i == ($prev+1))) {
				push $res->[$j]->@*, $i;
                $added = 1;
                last;
			}
		}
        return -1 unless $added;
	}
    
	return $res;
}

is_deeply(rearrange_groups($cases->[0]->@*), [[1,2,3], [1,2,3], [5,6,7]], '[1,2,3,5,1,2,7,6,3], 3');
is_deeply(rearrange_groups($cases->[1]->@*), -1,                          '[1,2,3],             2');
is_deeply(rearrange_groups($cases->[2]->@*), [[1,2,3], [3,4,5]],          '[1,2,4,3,5,3],       3');
is_deeply(rearrange_groups($cases->[3]->@*), -1,                          '[1,5,2,6,4,7],       3');

done_testing();



exit 0;

