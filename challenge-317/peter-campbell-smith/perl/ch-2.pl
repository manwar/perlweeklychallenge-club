#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-14
use utf8;     # Week 317 - task 2 - Friendly strings
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

# these are true
friendly_strings('stripe', 'sprite');
friendly_strings('xxAxxBxx', 'xxBxxAxx');
friendly_strings('AxxxxxxB', 'AxxxxxxB');
friendly_strings('mmmmm', 'mmmmm');
friendly_strings('hippopotamus', 'hippopotamsu');
friendly_strings('identical', 'identical');

# these are false
friendly_strings('shorter', 'shorterx');
friendly_strings('longer', 'longe');
friendly_strings('completely', 'differents');
friendly_strings('friendly', 'friendly');

sub friendly_strings {
	
	my ($string1, $string2, $result, @chars1, $j, $k, @chars3, $string3, $x);
	
	# initialise
	($string1, $string2) = @_;
		$result = 'false';
	@chars1 = split('', $string1);
	
	# strings must be same length
	if (length($string1) == length($string2)) {
		
		# loop over all pairs
		F: for $j (0 .. length($string1) - 2) {
			for $k ($j + 1 .. length($string1) - 1) {
				
				# swap 2 characters in string1
				@chars3 = @chars1;
				$x = $chars3[$j];
				$chars3[$j] = $chars3[$k];
				$chars3[$k] = $x;
				$string3 = join('', @chars3);
				
				# and compare with string2
				if ($string3 eq $string2) {
					$result = qq[true - '$x' and '$chars3[$j]'];
					last F;
				}
			}
		}			
	}
	
	# report results
	say qq[\nInput:  \$string1 = '$string1', \$string2 = '$string2'];
	say qq[Output: $result];
}
