#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2026-10-05
use utf8;     # Week 394 - task 1 - Alternate case
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

alternate_case('aAbB');
alternate_case('AAbb');
alternate_case('AAAbbb');
alternate_case('aABb');
alternate_case('bBBAaa');
alternate_case('WEEKLYweeklyCHALLENGEchallenge');

sub alternate_case {
	
	my ($string, $uppers, $lowers, $length, @array, $prev, $j, $k, 
		@swaps, $m, $x, @reverse, $output);
	
	# initialise
	$string = $_[0];
	say qq[\nInput:  '$string'];
	
	# validate input
	$uppers = () = $string =~ m|[A-Z]|g;
	$lowers = () = $string =~ m|[a-z]|g;
	$length = $uppers + $lowers;
	if (abs($uppers - $lowers) > 1 or 
		$uppers + $lowers != length($string)) {
		say qq[Output: bad string ($uppers uppers, $lowers lowers)];
		return;
	}

	# try string as is, and with first 2 chars reversed
	for $m (1 .. 2) {
		
		# second pass
		$string = substr($string, 1, 1) . substr($string, 0, 1) .
			substr($string, 2, 1000) if $m == 2;
	
		# create array of 1s (upper case) and 0s (lower)
		$array[$_] = is_upper(substr($string, $_, 1)) ? 1 : 0 
			for 0 .. length($string) - 1;
		$prev = $array[0];
		$swaps[$m] = $m - 1;
		
		# loop over array, moving elements if needed
		J: for $j (1 .. $#array - 1) {
			if ($array[$j] == $prev) {
				for $k ($j + 1 .. $#array) {
					if ($array[$k] != $prev) {
						move(\@array, $k, $j);
						$swaps[$m] += $k - $j;
						last;
					}
				}
			}
			$prev = $array[$j];
		}
	}
	
	$j = $swaps[1] > $swaps[2] ? $swaps[2] : $swaps[1];
	say qq[Output: $j swap] . ($j == 1 ? '' : 's');
}

# 1 for upper case, 0 for lower
sub is_upper {
	return ord($_[0]) > ord('Z') ? 0 : 1;
}

# move element $k to position $j
sub move {
	
	my ($array, $j, $k, $x, $y, @old);
	
	($array, $k, $j) = @_;
	
	# reassemble @array
	@old = @$array;
	@$array = ();
	push @$array, @old[0 .. $j - 1];
	push @$array, $old[$k];
	push @$array, @old[$j .. $k - 1];
	push @$array, @old[$k + 1 .. $#old];
}
