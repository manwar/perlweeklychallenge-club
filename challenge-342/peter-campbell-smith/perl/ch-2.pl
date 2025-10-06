#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-10-06
use utf8;     # Week 342 - task 2 - Max score
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

max_score('0011');
max_score('0000');
max_score('1111');
max_score('011101');
max_score('10');

my $string;
$string .= int(rand(2)) for 0..99;
max_score($string);

sub max_score {
	
	my ($string, @numbers, $score, $best, $j, $explain);
	
	# initialise
	$string = shift;
	@numbers = split('', $string);
	$best = -1;
	
	# count all the 1s
	$score += $_ for @numbers;
	
	# move the boundary steadily right, adjusting the score
	for $j (0 .. length($string) - 2) {
		$score += $numbers[$j] == 1 ? -1 : 1;
		
		# check if this is the best
		next unless $score > $best;
		$best = $score;
		$explain = substr($string, 0, $j + 1) . '~' . substr($string, $j + 1);
	}
	
	# report
	say qq[\nInput:  '$string'];
	say qq[Output: $best: $explain];
}
