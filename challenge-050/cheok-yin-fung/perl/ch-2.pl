#!/usr/bin/perl
use strict;

# Caution: This script is valid only when the list of integers DISTINCT.

# Proposition: There can only be 1 noble integer. 
# Proof by Contradiction: 
# Let r be the length of the list, 
# k be the firstly found noble integer 
# and j be the secondly found noble integer
# (by this algorithm, the first found noble integer will be the smallest noble integer;)
# (by the DISTINCT assumption, k<j     #(a)
# numbers of integers larger than k: r - position(k)
# numbers of integers larger than j: r - position(j) , 
#     while r-position(j) < r-position(k),             #(b)
#               since position(j) > position(k) after sorting.
# By the nobleness condition
#     k == r-position(k)     #(c)
#     j == r-position(j)     #(d)
#     Substituting (c) & (d) into (a) implies r-position(k) < r-position(j) , while this inequality violates (b) !!! QED

my @L = @ARGV; #usage: perl ch-2.pl 2 6 1 3


@L = sort {$a <=> $b} @L;


my $i=0;
while ($i<=$#L) {
	if ($L[$i] == $#L-$i ) {print $L[$i]; exit;} 
	$i++;
}
print "-1";
