#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-09-07
use utf8;     # Week 390 - task 2 - Order characters
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

order_characters('dbca', 1);
order_characters('geeks', 2);
order_characters('cbaed', 3);
order_characters('fedcba', 4);
order_characters('perl', 1);
order_characters('oloolooo',1);
order_characters('oloooolo', 1);
order_characters('penguin', 2);
order_characters('moratorium', 4);
order_characters('equilibrium', 6);

sub order_characters {
	
	my ($string, $k, $new, $best, $r, $j, $least, $c, $limit);
	
	($string, $k) = @_;
	say qq[\nInput:  \$string = '$string', \$k = $k];
	
	# at least two letters
	if ($k >= 2) {
		
		# best = letters fully sorted
		$best = join('', sort { $a cmp $b } split(//, $string));
		
		# randomly select one of the $k initial letters
		$limit = 10 ** 7;
		for ($j = 0; $j <= $limit; $j ++) {
			$r = int(rand($k));			
			$new = '';
			$new .= substr($string, 0, $r) unless $r == 0;
			$new .= substr($string, $r + 1, 99) .=
				    substr($string, $r, 1);	
			last if $new eq $best or $j == $limit;
			$string = $new;
		}

		say qq[Output: ] . ($j <= $limit ? qq[$new ($j tries)] : 
			'failed!');
		
	# only one letter - can only rotate letters
	} elsif ($k == 1) {		
		$best = $string;
		for $k (0 .. length($string) - 1) {
			$string = substr($string, 1, 9999) . 
			          substr($string, 0, 1);
			$best = $string if $string lt $best;
		}
		say qq[Output: '$best'];
	}
}
