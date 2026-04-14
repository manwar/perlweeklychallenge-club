#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-04-13
use utf8;     # Week 369 - task 2 - Group division
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

group_division('RakuPerl', 4, '*');
group_division('Python', 5, '0');
group_division('12345', 3, 'x');
group_division('HelloWorld', 3, '_');
group_division('AI', 5, '!');

sub group_division {
	
	my ($string, $size, $filler, $output);
	
	# initialise
	($string, $size, $filler) = @_;
	say qq[\nInput:  \$string = '$string', \$size = $size, \$filler = '$filler'];
	
	# append $filler x $size unless length is a multiple of $size
	$string .= $filler x $size unless length($string) % $size == 0;
	
	# match characters $size at a time
	$output .= qq['$1', ] while $string =~ m|(.{$size})|g;
	
	# report
	say qq[Output: ] . substr($output, 0, -2);
}
