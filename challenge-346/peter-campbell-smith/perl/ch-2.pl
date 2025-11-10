#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-11-03
use utf8;     # Week 346 - task 2 - Magic expression
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;
use Algorithm::Combinatorics 'variations_with_repetition';

magic_expression(123, 6);
magic_expression(105, 5);
magic_expression(232, 8);
magic_expression(1234, 10);
magic_expression(13579, 115);
magic_expression(314159265, 868140);

sub magic_expression {
	
	my (@ints, $target, $gaps, @ops, $iterator, $p, $trial, $g, $value, $output);
	
	# initialise
	@ints = split('', $_[0]);
	$target = $_[1];
	$gaps = $#ints;
	@ops = (' + ', ' - ', ' * ', '');
	$output = '';
	
	# loop over variations of @ops
	$iterator = variations_with_repetition([0, 1, 2, 3], $gaps);
	while ($p = $iterator->next) {
		
		# create string of digits with every perm of @ops
		$trial = '';
		for $g (0 .. $gaps - 1) {
			$trial .= $ints[$g] . $ops[$p->[$g]];
		}
		$trial .= $ints[$gaps];
		
		# eliminate ones containing leadng 0s eg 05
		next if $trial =~ m{( 0\d|\(0\d)};
		
		# evaluate the string and see if it matches $target
		$value = eval($trial);
		next unless $value == $target;
		
		# it does
		$output .= qq[($trial), ];
	}
		
	say qq[\nInput:  \$str = '$_[0]', \$target = $target];
	say qq[Output: \$output = ] . ($output ? substr($output, 0, -2) : 'not possible');
}
