#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-07-31
use utf8;     # Week 228 task 1 - Unique sum
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use List::Uniq 'uniq';

my ($j, @int);

unique_sum(2, 1, 3, 2);
unique_sum(1, 1, 1, 1);

# longer example
for $j (1 .. 12) {
	push (@int, int(rand(9) + 1));
}
unique_sum(@int);

sub unique_sum {
	
	my $sum;
	$sum += $_ for uniq(@_);
	
	say qq[\nInput:  \@int = (] . join(', ', @_) . ')';
	say qq[Output: ] . (defined($sum) ? $sum : 0);
}
