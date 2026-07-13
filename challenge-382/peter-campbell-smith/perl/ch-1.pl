#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/382/1

use v5.26;    # The Weekly Challenge - 2026-07-13
use utf8;     # Week 382 - task 1 - Hamiltonian cycle
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

my ($count, @followers, $output);

for (5, 10, 20, 30 .. 36) {
	hamiltonian_cycle($_);
}

sub hamiltonian_cycle {
	
	my ($i, @squares, $s, $possible);
	
	# find squares from 2 to 2 * $count - 2
	$count = $_[0];
	for $i (2 .. 99) {
		last if $i ** 2 > 2 * $count - 1;
		push @squares, $i ** 2;
	}
	
	# find the numbers that can follow $a
	@followers = ();
	for $a (1 .. $count) {
		for $s (@squares) {
			$possible = $s - $a;
			last if $possible > $count;
			next if ($possible <= 0 or $possible == $a);
			$followers[$a] .= qq[~$possible~];
		}
	}

	# start with 1 and complete recursively
	$output = '';
	try ([1]);
	
	# report
	say qq[\nInput:  $count];
	say qq[Output: ] . ($output or 'none found');
}

sub try {   # adds a valid number to @so_far
	
	my (@so_far, $last, @trial, $this);
	
	# do we have all the numbers?
	@so_far = @{$_[0]};
	if (@so_far == $count) {
		
		# and is the first number a follower of the last?
		if ($followers[$so_far[$count - 1]] =~ m|~$so_far[0]~|) {
			$output = join(', ', @so_far);
			return;
		}
	}
	
	# else recurse by appending each of the followers of the
	# last one added
	$last = $so_far[-1];
	F: while ($followers[$last] =~ m|(\d+)|g) {
		$this = $1;
		
		# can't add one we've already added
		for (@so_far) {
			next F if $this == $_;
		}
		
		# good so far so add another number
		@trial = @so_far;
		push @trial, $this;
		try (\@trial);
		
		# found an answer!
		return if $output;
	}
}
