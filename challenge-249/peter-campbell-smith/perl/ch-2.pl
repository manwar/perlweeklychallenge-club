#!/usr/bin/perl

use v5.26;    # The Weekly Challenge - 2023-12-25
use utf8;     # Week 249 task 2 - DI string match
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge
no warnings 'recursion';

my (@di);

di_string_match('IDID');
di_string_match('III');
di_string_match('DDI');
di_string_match('DDIIDIDDIIIDDIDIIDIIIIDD');
di_string_match('DIDIDIDIDI');

sub di_string_match {
	
	my ($str, @nums, @perm, @new_nums, $i, $good);	
	
	# initialise
	$str = $_[0];
	say qq[\nInput:  \$str = '$str'];
	@di = split('', $str);
	$nums[$_] = 1 for 0 .. @di;

	# try all possible initial numbers
	for $i (0 .. @di) {
		@perm = ($i);
		@new_nums = @nums;
		@new_nums[$i] = -1;
		$good = get_next(1, \@new_nums, \@perm);
		last if $good;
	}
	
	say qq[Output: no valid permutation] unless $good;
}

sub get_next {

	my ($i, @perm, $this_di, $n, @nums, @new_nums, @new_perm, $good);
	
	$i = $_[0]; 		        # looking for $perm[$i];
	@nums = @{$_[1]};		    # numbers still unused
	@perm = @{$_[2]};           # answer so far
	$this_di = $di[$i - 1];	    # D or I at position $i

	# find numbers valid at this position
	for $n (0 .. @nums - 1) {
		
		# number already used
		next unless $nums[$n] >= 0;
		
		# number not < or > as required by D or I
		next if ($this_di eq 'D' and $n > $perm[$i - 1]);
		next if ($this_di eq 'I' and $n < $perm[$i - 1]);
		
		# good so far and if we've reached the end of $str we have an answer
		@new_perm = @perm;
		$new_perm[$i] = $n;
		if ($i == @di) {
			say qq[Output: (] . join(', ', @new_perm) . ')';
			return 1;
		}
		
		# else recurse to get next value in @perm
		@new_nums = @nums;
		$new_nums[$n] = -1;
		$good = get_next($i + 1, \@new_nums, \@new_perm);
		
		# finished
		return 1 if $good;
	}
	
	# no valid perm - but I don't think that can happen
	return 0;
}
