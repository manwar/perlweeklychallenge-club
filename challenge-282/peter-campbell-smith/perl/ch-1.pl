#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-08-12
use utf8;     # Week 282 - task 1 - Good integer
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

# good ones
good_integer('12333456');
good_integer('333456');
good_integer('456333');
good_integer('129934956799998999');

# bad ones
good_integer('123333456');
good_integer('3333456');
good_integer('123333');
good_integer('123345');

sub good_integer {
	
	my $int = $_[0];
	say qq[\nInput:  \$int = $int];
	
	# pad left and right with non-integer
	$int = qq[¦$int¦];
	
	# check for xyyyz pattern
	while ($int =~ m|(.)(.)\2\2(.)|g) {
		next unless ($1 ne $2 and $2 ne $3);
		
		# pattern found!
		say qq[Output: $2$2$2];
		return;
	}
	say qq[Output: -1];
}
