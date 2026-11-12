#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/399/1

use v5.26;    # The Weekly Challenge - 2026-11-09
use utf8;     # Week 399 - task 1 - Longest repeating character
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

longest_repeating_character('ABCDE', 4);
longest_repeating_character('AAABBBBAA', 1);
longest_repeating_character('ABACADA', 2);
longest_repeating_character('BAAABAAAA', 1);
longest_repeating_character('ABBBBA', 2);
longest_repeating_character('A', 0);
longest_repeating_character('AABBBAA', 2);
longest_repeating_character('AABBBAA', 3);
longest_repeating_character('AABBBB', 1);
 
# longer example - 50 x random A to F
my $string;
$string .= chr(ord('A') + int(rand(6))) for (1 .. 50);
longest_repeating_character($string, 4);

sub longest_repeating_character {
	
	my (@string, $j, $consec_char, @changed, $k, $kk, $i, $best,
		$best_letter, @best_string, $consec, $z, $k_save);
	
	# initialise
	@string = split(//, $_[0]);
	return if $#string < 2;
	$k = $_[1];
	$best = 0;
	
	# forward then reverse passes
	for $z (1, 2) {
		if ($z == 2) {
			last if $k_save == 0;
			$k = $k_save;
			@string = reverse @best_string;
		}

		# loop over posssible starting point of substring
		J: for $j (0 .. $#string) {
			
			# make new string candidate
			$kk = $k;
			$consec_char = $string[$j];
			@changed = @string;
			$consec = 1;
			
			# change up to $k chars to match $consec_char
			I: for $i ($j + 1 .. $#string) {
				if ($changed[$i] eq $consec_char) {
					$consec ++;
				} elsif ($kk > 0) {
					$changed[$i] = $consec_char;
					$consec ++;
					$kk --;
				}
			
				# is this the best?
				if ($consec > $best) {
					$best = $consec;
					$best_letter = $consec_char;
					@best_string = $z == 1 ? 
						@changed : reverse @changed;
					$k_save = $kk;
				}
				last I if ($kk == 0 and $changed[$i] ne $consec_char);
			}
		}
	}
	
	# report
	say qq[\nInput:  \$string = '$_[0]', \$k = $_[1]];
	say qq[Output: \$string = '] . join('', @best_string) . 
		qq[' containing '$best_letter' $best consecutive times];
}
