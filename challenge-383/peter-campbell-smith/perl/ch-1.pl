#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/383/1

use v5.26;    # The Weekly Challenge - 2026-07-20
use utf8;     # Week 383 - task 1 - Similar list
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

similar_list(['great', 'acting'], ['fine', 'drama'], 
	[['great', 'fine'], ['acting', 'drama']]);
similar_list(['apple', 'pie'], ['banana', 'pie'], [['apple', 'peach'], 
	['peach', 'banana']]);
similar_list(['perl4', 'python'], ['raku', 'python'], 
	[['perl4', 'perl5', 'raku']]);
similar_list(['enjoy', 'challenge'], ['love', 'weekly', 'challenge'], 
	[['enjoy', 'love']]);
similar_list(['fast', 'car'], ['quick', 'vehicle'], 
	[['quick', 'fast'], ['vehicle', 'car']]);
similar_list([qw[the quick brown fox jumps over the lazy dog]],
		[qw[hound a tan vaults the speedy sleepy wolf above]],
		[['the', 'a'], ['speedy', 'quick'], ['brown', 'tan'], 
		['fox', 'wolf'], ['vaults', 'jumps'], ['above', 'over'], 
		['the', 'my'], ['sleepy', 'lazy'], ['hound', 'dog']]);

sub similar_list {
	
	my (@list1, @list2, @lists3, $k1, $k2, $i3, $j3, %similar, $word, 
		@sims, $list, $s, $first);
	
	# initialise
	@list1 = @{$_[0]};
	@list2 = @{$_[1]};
	@lists3 = @{$_[2]};
	say qq[\nInput:  \@list1 = ('] . join(q[', '], @list1) . q[')];
	say   qq[        \@list2 = ('] . join(q[', '], @list2) . q[')];
	say   qq[        \@lists3[$_] = ('] . 
		join(q[', '], @{$lists3[$_]}) . q[')] for 0 .. $#lists3;
	
	# make lists of similar words, eg ~great~fine~
	for $j3 (0 .. $#lists3) {
		$sims[$j3] = '~' . join('~', @{$lists3[$j3]}) . '~';
	}
	
	# subsitute first in those lists for any in list1 and list2
	for $list (\@list1, \@list2) {
		for $k1 (0 .. @$list - 1) {
			for $s (@sims) {
				if ($s =~ m|~$list->[$k1]~|) {
					($first) = $s =~ m|(~\w+~)|;
					$list->[$k1] = $first;
				}
			}
		}
	}
	
	# report
	say 'Output: ' . 
		(join(',', sort @list1) eq join(',', sort @list2) ? 
		'true' : 'false');
}
