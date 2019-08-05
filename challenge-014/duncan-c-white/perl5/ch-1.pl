#!/usr/bin/perl

# Challenge 1: "Write a script to generate Van Eck's sequence starts with 0. 
# Van Eck's sequence is defined by:
# 
# Let a0 = 0. Then, for n >= 0, if there exists an m < n such that am = an, take
# the largest such m and set an+1 = n - m; otherwise an+1 = 0.
# 
# Thus the first occurrence of an integer in the sequence is followed by
# a 0, and the second and subsequent occurrences are followed by the size
# of the gap between the two most recent occurrences.
# 
# The first few terms of the sequence are(OEIS: A181391):
# 
#     0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5..
# "
# 
# My notes:
# 
# Sounds easy enough (and not, in fact, obviously recursive).


use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-1.pl NTERMS\n" unless @ARGV==1;
my $nterms = shift;


#
# my $next = nextitem( $n, $seq );
#	Given @$seq[0..$n] have been calculated,
#	calculate the next value in the sequence,
#	ie. what will become $seq[$n+1]
#
fun nextitem( $n, $seq )
{
	my $target = $seq->[$n];
	for( my $m=$n-1; $m>=0; $m-- )
	{
		return $n-$m if $seq->[$m] == $target;
	}
	return 0;
}


my @seq = ( 0 );

print "seq[0] = 0\n";

foreach my $n (0..$nterms)
{
	my $next = nextitem( $n, \@seq );
	my $np1 = $n+1;
	print "seq[$np1] = $next\n";
	push @seq, $next;
}
