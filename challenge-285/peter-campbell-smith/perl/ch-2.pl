#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-09-02
use utf8;     # Week 285 - task 2 - Making change
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

making_change(9);
making_change(15);
making_change(100);
making_change(500);

sub making_change {
	
	my ($cents, $h, $q, $d, $n, $p, @sum, $count, $explain);
	
	# initialise
	$cents = $_[0];
	$count = 0;
	$explain = '';
	
	# intelligently loop over all combs
	H: for $h (0 .. 1e6) {
		$sum[0] = $h * 50;
		last H if $sum[0] > $cents;

		Q: for $q (0 .. 1e6) {
			$sum[1] = $sum[0] + $q * 25;
			last Q if $sum[1] > $cents;

			D: for $d (0 .. 1e6) {
				$sum[2] = $sum[1] + $d * 10;
				last D if $sum[2] > $cents;

				N: for $n (0 .. 1e6) {
					$sum[3] = $sum[2] + $n * 5;
					last N if $sum[3] > $cents;

					P: for $p (0 .. 1e6) {
						$sum[4] = $sum[3] + $p;
						
						# found a valid combination
						if ($sum[4] == $cents) {
							$count ++;
							$explain .= qq[  $count: ${h}H + ${q}Q + ${d}D + ${n}N + ${p}P\n];
						}
						last P if $sum[4] >= $cents;
					}
				}
			}
		}
	}
	
	# output
	say qq[\nInput:  \$cents = $cents];
	$explain = qq[\n] if $count > 300;
	$explain =~ s| \+ 0.||gm;
	$explain =~ s|0H \+ ||gm;
	print qq[Output: $count\n$explain];	
}

