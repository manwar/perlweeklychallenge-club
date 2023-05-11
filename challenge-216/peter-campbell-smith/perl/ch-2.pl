#!/usr/bin/perl

use v5.16;    # The Weekly Challenge - 2023-05-08
use utf8;     # Week 216 task 2 - Word stickers
use strict;   # Peter Campbell Smith
use warnings; # Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

word_stickers(['perl','raku','python'], 'peon');
word_stickers(['love','hate','angry'], 'goat');
word_stickers(['come','nation','delta'], 'accommodation');
word_stickers(['nail', 'sited', 'belt', 'marsh'], 'antidisestablishmentarianism');

sub word_stickers {
	
	my ($best, $count, $how_many, $most, $need_to_match, $occurs, $occurs_in, $rubric, $s, 
		$s1, $stars, $ties, $times, $times_all, $times_here, $to_match, $word, $x, $x1, $z, %in_sticker, %in_word, %needed, %used, @stickers);
	
	# initialise
	@stickers = @{$_[0]};
	$word = $_[1];
	$rubric = '';
	say qq[\nInput:  \@stickers = ('] . join(qq[', '], @stickers) .
		qq['), \$word = '$word'];
	
	# create $in_word{$x} as quantity of $x in $word
	while ($word =~ m|([a-z])|g) {
		$in_word{$1} ++;
	}
	
	# create $in_sticker{$x}{$s} as quantity of $x in $stickers[$s]
	for ($s = 0; $s < scalar @stickers; $s ++) {
		while ($stickers[$s] =~ m|([a-z])|g) {
			$in_sticker{$1}{$s} ++;
		}
	}
	
	# loop over letters in $word
	for $x (sort keys %in_word) {
		next unless $in_word{$x} > 0;
		
		# check for $x n times in stickers and >=n times in word 
		for $x (keys %in_word) {
			$most = 0;
			
			# find sticker with most $x - this may not be the best
			$times_all = 0;
			for ($s = 0; $s < scalar @stickers; $s ++) {
				$times_here = ($in_sticker{$x}{$s} or 0);
				$times_all += $times_here;
				if ($times_here > $most) {
					$most = $times_here;
					$best = $s;
				}
			}
			
			# check for impossibility (letter from word not in any sticker)
			if ($most == 0) {
				say qq[Output: 0 - '$x' not in any sticker];
				return;
			}
			
			# if $x occurs more times in word than in stickers,
			# need to add duplicate stickers
			$need_to_match = $in_word{$x};
			$z = 0;
			while ($need_to_match > $times_all) {
				$s1 = scalar @stickers;
				$stickers[$s1] = $stickers[$best] . '*';
				for $x1 (keys %in_word) {
					$in_sticker{$x1}{$s1} = $in_sticker{$x1}{$best};
				}
				$need_to_match -= $in_sticker{$x}{$best};
			}
			
			# now we have enough stickers
			$need_to_match = $in_word{$x};
			for ($s = 0; $s < scalar @stickers; $s ++) {
				next unless ($in_sticker{$x}{$s} or 0);
				$to_match = $need_to_match > $in_sticker{$x}{$s} ? 
					$in_sticker{$x}{$s} : $need_to_match;
				$need_to_match -= $to_match;
				$used{$s} .= $x x $to_match;
				$in_sticker{$x}{$s} = 0;
				$in_word{$x} = 0;
				$needed{$s} = 1;
				last if $need_to_match <= 0;
			}
			$in_word{$x} = 0;
		}
	}
	
	# format output
	$count = 0;
	for $s (keys %needed) {
		$count ++;
	}
	say qq[Output: $count];
	for $s (sort keys %used) {
		say qq[   '$used{$s}' from '$stickers[$s]'];
		$stars ++ if $stickers[$s] =~ m|\*|;
	}
	say qq[   * indicates duplicated sticker] if $stars;
}
