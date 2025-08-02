#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-03-25
use utf8;     # Week 262 - task 1 - Max positive negative
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

my (@ints, $j, $num);

max_positive_negative(-3, 1, 2, -1, 3, -2, 4);
max_positive_negative(-1, -2, -3, 1);
max_positive_negative(1, 2);

# larger example
$j = 0;
while ($j < 100) {
	$num = int(rand(100)) - 50;
	$ints[$j ++] = $num if $num;
}
max_positive_negative(@ints);

sub max_positive_negative {
	
	my (@ints, @count);
	
	# initialise
	@ints = @_;
	@count = (0, 0);
	
	# count positive and negative values
	$count[$_ < 0 ? 0 : 1] ++ for @ints;
	
	# show result
	say qq[\nInput:  \@ints = (] . join(', ', @ints) . q[)];
	say qq[Output: ] . ($count[0] > $count[1] ? $count[0] : $count[1]) .
		qq[ ($count[0] negative, $count[1] positive)];
}
