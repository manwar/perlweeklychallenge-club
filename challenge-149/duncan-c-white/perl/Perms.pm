package Perms;

# 
# Generate permutations, one at a time, using a
# standard lexicographic permutation algorithm.
# 

use strict;
use warnings;
use feature 'say';
#use Data::Dumper;

#
# my $next = next_perm( $val );
#	Find and return the next permutation in lexicographic order
#	of $val.  Return undef is $val is the last permutation (in order).
#	Algorithm treats $val as an array of digits a[n]:
#	1. Find the largest index k such that a[k] < a[k + 1]. If no such index exists,
#	   the permutation is the last permutation.
#       2. Find the largest index l greater than k such that a[k] < a[l].
#       3. Swap the value of a[k] with that of a[l].
#       4. Reverse the sequence from a[k + 1] up to and including the final element a[n].
#
sub next_perm ($)
{
	my( $val )= @_;
	my @a = split( //, $val );
	my( $k, $l );
	my $n = @a-1;
	for( $k=$n-1; $k>=0 && ord($a[$k])>=ord($a[$k+1]); $k-- )
	{
	}
	return undef if $k<0;
	for( $l=$n; $l>$k && ord($a[$k])>=ord($a[$l]); $l-- )
	{
	}
	( $a[$k], $a[$l] ) = ( $a[$l], $a[$k] );

	# reverse a[k+1]..a[n]
	@a[$k+1..$n] = reverse @a[$k+1..$n];

	return join( '', @a );
}


1;
