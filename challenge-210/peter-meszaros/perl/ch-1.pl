#!/usr//bin/perl
# Example 1
# 
# Input: @int = (2, 3, 1)
# Output: 6
# 
# First we delete 2 and that would also delete 1 and 3. So the maximum points we get is 6.
# 
# Example 2
# 
# Input: @int = (1, 1, 2, 2, 2, 3)
# Output: 11
# 
# First we delete 2 and that would also delete both the 1's and the 3. Now we have (2, 2).
# Then we delete another 2 and followed by the third deletion of 2. So the maximum points we get is 11.

use strict;
use warnings;
use List::MoreUtils qw(uniq);
use List::Util qw(sum0);
use Test::More;

my $cases = [
	[2, 3, 1],
	[1, 1, 2, 2, 2, 3],
];

sub killnum
{
	my $aref = shift;
    my @uniq = uniq @$aref;

    my $sum = 0;
    for my $n (@uniq) {
		my $r = sum0(grep { $_ >= $n-1 or $_ <= $n+1} @$aref);
        $sum = $r if $r > $sum;
	}
	return $sum;
}

is(killnum($cases->[0]),  6, '[2, 3, 1]');
is(killnum($cases->[1]), 11, '[1, 1, 2, 2, 2, 3]');

done_testing();

exit 0;

