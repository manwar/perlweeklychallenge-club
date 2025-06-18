#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-06-16
use utf8;     # Week 326 - task 2 - Decompressed list
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

decompressed_list(1, 3, 2, 4);
decompressed_list(1, 1, 2, 2);
decompressed_list(3, 1, 3, 2);

# bigger example
my @ints;
push @ints, int(rand(5) + 1) for 0 .. 99;
decompressed_list(@ints);

sub decompressed_list {
	
	my (@list, @new_list, $j);
	
	# initialise
	@list = @_;
	
	# do what it says
	for ($j = 1; $j <= $#list; $j += 2) {
		push @new_list, $list[$j] for 1 .. $list[$j - 1];
	}
	
	# report
	say qq[\nInput:  \@ints1 = (] . join(', ', @list) . q[)];
	say qq[Output: \@ints2 = (] . join(', ', @new_list) . q[)];
}
