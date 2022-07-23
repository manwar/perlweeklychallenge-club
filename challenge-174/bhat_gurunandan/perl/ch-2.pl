#!/usr/bin/env perl

use 5.36.0;

use integer;

sub factorials ($n) {

	my $out = [1];
	for (1 .. $n - 1) {
		push @$out, $_ * $$out [-1];
	}

	return $out;
}

# _rank ($a, $n)
#
# $a = array reference to individual elements of the permutation
# $n index of the element in the array 'a'
#
# Finds the rank of the elelemt at index $n in array 'a' wrt the
# sorted array
#

sub _rank ($a, $n) {

	my $rank = $$a [$n];
	return $rank unless ($n > 0);

	my $this = $$a [$n];
	for (0 .. $n) {
		-- $rank if $this > $$a [$_];
	}

	return $rank;
}

# perm2rank ($str)
#
# $str: A permutation of 0 .. n-1 as a concatenated string
# returns the rank of $str
#
sub perm2rank ($str) {

	my @perm = map { int $_ } split //, $str;

	my $rank = 0;
	my $fact = 1;
	my $elems = scalar @perm;

	# reverse the loop over elements for efficient factorials
	for (reverse 0 .. $#perm) {

		$rank += $fact * _rank (\@perm, $_);
		$fact *= ($elems - $_);
	}

	return $rank;
}

# rank2perm ($rank, $dim)
#
# $rank - the rank whose permutation we want
# $dim  - the dimension of the set that is permuted.
#         Note that for $dim, the set is 0 - $dim -1
#

sub rank2perm ($rank, $dim) {

	my $factorials = factorials ($dim);
	my @_initial = 0 .. $dim - 1;

	my $perm;
	for (0 .. $dim - 1) {

		my $fact = pop @$factorials;

		my $pos  = $rank / ($fact);
		   $rank = $rank % $fact;

		$perm .= splice @_initial, $pos, 1;
	}

	return $perm;
}

my $str = $ARGV [0];
my $rank = perm2rank ($str);
my $perm = rank2perm ($rank, length ($str));

say "The rank of $str is $rank and " .
    "the permutation of rank $rank is $perm"
