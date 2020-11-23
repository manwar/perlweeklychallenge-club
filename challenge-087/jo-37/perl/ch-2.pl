#!/usr/bin/perl

use 5.012;
use PDL;
use Test2::V0 '!float';
#use Digest::xxHash 'xxhash64';
no warnings 'recursion';

#BEGIN {
#	$::seed = time;
#}

# Uncomment to enable trace output and additional examples:
#$::verbose = 1;

# Generate trace output including the recursion level and depending on
# the verbose setting.
our $level;
sub trace {
	say "$level> ", @_ if $::verbose;
}

# Recursively find a maximum submatrix consising of only non-zero
# elements with a size larger than the given current maximum.  Extending
# the task to any non-zero values instead of ones. 
sub maxrect_r;
sub maxrect_r {
	local $level = defined $level ? $level + 1 : 0;

	# Maximum to be surpassed:
	my $max = shift;
	# Provide a default result.
	my $maxrect = PDL->null;
	
	# Matrix to be examined:
	my $m = shift;
	trace "in: $m";

	# Hash ref containing already processed parts:
	my $seen = shift;

	# Could use a hash over the matrix' string representation for its
	# identification.  Any "good" hashing algorithm may be used.  For
	# the sake of convenience it is omitted here and the string
	# representation itself is used.
#	our $seed;
#	my $hash = xxhash64 $m, $seed;
	my $hash = "$m";

	# Avoid reprocessing of the same data.
	trace("seen"),
	return $maxrect if $seen->{$hash};

	# Record the given matrix as seen.
	$seen->{$hash} = 1;

	# Count non-zero elements:
	my $nonzero = $m->where($m)->nelem;

	# There cannot be a new maximum inside this matrix if there are not
	# enough non-zeroes in it.
	trace("cut"),
	return $maxrect if $nonzero <= $max;

	# A new maximum is found at this point if all elements of the matrix
	# are non-zero, i.e. the count equals the product of the dimensions.
	trace("out: max=$nonzero $m"),
	return $m if $nonzero == prod($m->shape);

	# Lists of indices for both dimensions to be used as slicing /
	# dicing arguments.
	my $i0 = sequence $m->dim(0);
	my $i1 = sequence $m->dim(1);

	# Get coordinates of all zeroes in $m.
	my $zeroes = whichND(!$m);

	# Get the coordinates of a zero most central in the matrix.
	# This is not really necessary as any zero could be used here.
	# Explanation: take the difference from the coordinates to the
	# middle of the matrix, add the absolute values of these, find
	# the index where a minimum is obtained and finally select the zero
	# at the selected index.
	my $zero = $zeroes->slice([],
		[minimum_ind(abs($zeroes - ($m->shape-1)/2)->sumover), undef, 0]);

	trace "zero at $zero";

	# Obviously, a zero element is not part of any non-zero rectangle,
	# even less of a maximum one.  Thus the matrix can be decomposed
	# into four (possibly empty) sub matrices avoiding it: left, right,
	# above and below of it.  (The special choice of the zero element
	# results in a decomposition as even as possible.) Recurse into each
	# non-empty sub matrix and take any new found maximum.  As the sub
	# matrices overlap, already processed parts are tracked to prevent
	# the overhead of reprocessing.
	my $part;
	foreach (	# slice (or rather: dice) arguments for the four sub
				# matrices:
			[$i0->where($i0 < $zero->at(0)), $i1],
			[$i0->where($i0 > $zero->at(0)), $i1],
			[$i0, $i1->where($i1 < $zero->at(1))],
			[$i0, $i1->where($i1 > $zero->at(1))]) {

		trace "part #", ++$part;

		# Skip empty slices.
		trace("empty"),
		next if grep {$_->isempty} @$_;

		# Recurse into the sub matrix.
		my $maxsub = maxrect_r $max, $m->slice(@$_), $seen;
		
		# Check for a new maximum.
		my $size = prod($maxsub->shape);
		($maxrect, $max) = ($maxsub, $size) if $size > $max;
	}
	trace "out: max=$max $maxrect" unless $maxrect->isempty;

	$maxrect;
}

# Convenience wrapper for maxrect_r.  Transform input data into a
# piddle, set the current maximum to 1 to avoid invalid trivial
# solutions and return the result as a perl array ref.
sub maxrect {
	maxrect_r(1, long(@_))->unpdl;
}


# main

is maxrect([
		[0, 0, 0, 1, 0, 0],
		[1, 1, 1, 0, 0, 0],
		[0, 0, 1, 0, 0, 1],
		[1, 1, 1, 1, 1, 0],
		[1, 1, 1, 1, 1, 0]]),

		[[1, 1, 1, 1, 1],
		 [1, 1, 1, 1, 1]], 'Example 1';

is maxrect([
		[1, 0, 1, 0, 1, 0],
		[0, 1, 0, 1, 0, 1],
		[1, 0, 1, 0, 1, 0],
		[0, 1, 0, 1, 0, 1]]), [], 'Example 2';

my $ex3 = [
		[0, 0, 0, 1, 1, 1],
		[1, 1, 1, 1, 1, 1],
		[0, 0, 1, 0, 0, 1],
		[0, 0, 1, 1, 1, 1],
		[0, 0, 1, 1, 1, 1]];
is maxrect($ex3),
		[[1, 1, 1, 1],
		 [1, 1, 1, 1]], 'Example 3';

SKIP: {
	skip "additional example", 2 unless $::verbose;
	my $m = long($ex3);
	my $ones = $m->where($m);
	$ones .= sequence($ones->dim(0)) + 1;

	# Example 3, enumerated
	is maxrect($m),
		[[12, 13, 14, 15],
		 [16, 17, 18, 19]], 'Example 3, enumerated';

	# Random data, 2/3 filled.
	my $r = byte(random(9, 9) * 3);
	$r .= ($r > 0);
	ok maxrect($r), "random example";
}

done_testing;
