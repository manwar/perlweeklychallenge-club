#!/usr/bin/env perl

use 5.36.0;

sub is_permutation ($this, $that) {

	# Checks if $this and $that are permutations of one another

	return if length ($this) != length ($that);

	my (%this, %that);
	%this = map {$_ => ++$this {$_}} split //, $this;
	%that = map {$_ => ++$that {$_}} split //, $that;

	# Compare the twop hashes with
	# no fear of autovivification!
	foreach my $key (keys %this) {

		# We have a digit in "this" that
		# is not in "theat". Stop checking
		return unless $that {$key};

		if ($this {$key} == $that {$key}) {

			delete $this {$key};
			delete $that {$key};
		}
	}

	return %this == 0 && %that == 0
}

my @times = (2 .. 6);
my $this = 0;

while (1) {

	my $count = 0;
	++ $this;

	for my $factor (@times) {

		# Stop checking further multiples
		# if the current one is not a
		# candidate
		last unless
		  is_permutation ($this, $factor * $this);

		++ $count;
	}
	last if @times == $count;
}

say "Smallest number is $this";
