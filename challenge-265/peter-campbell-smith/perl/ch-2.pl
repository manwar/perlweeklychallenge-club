#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2024-04-15
use utf8;     # Week 265 - task 2 - Completing word
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';

completing_word('aBc 11c', ['accbbb', 'abc', 'abbc']);
completing_word('Da2 abc', ['abcm', 'baacd', 'abaadc']);
completing_word('JB 007', ['jj', 'bb', 'bjb']);
completing_word('P A R A M O U N T', ['tnoumarap', 'aamnoprtu']);
completing_word('xxAAxx', ['xxAxx', 'xxAAxx', 'xxAAAxx']);
completing_word('zz', [qw[the weekly challenge is a puzzle]]);

sub completing_word {
	
	my ($str, @str, $s, $ss, $result, $shortest, $l);
	
	# initialise
	$str = $_[0];
	@str = @{$_[1]};
	say qq[\nInput:  \$str = '$str', \@str = ('] . join(q[', '], @str) . q[')];
	
	# create a regex match like a.*b.*c.* from the sorted alpha chars in $str
	$str =~ s|[^a-z]||gi;
	$str = join('', sort {$a cmp $b} split('', lc($str)));
	$str =~ s|(.)|$1.*|g;
	
	# loop over @str to find best match
	$shortest = 999;
	$result = q['', ];
	for $s (@str) {
		
		# sort and lower case the letters of $str[$i] and see if they match the regex
		$ss = join('', sort {$a cmp $b} split('', lc($s)));
		next unless $ss =~ m|$str|;
		
		# see if this is the shortest or equal shortest match
		$l = length($s);
		if ($l < $shortest) {
			$result = qq['$s', ];
			$shortest = $l;
		} elsif ($l == $shortest) {
			$result .= qq['$s', ];
		}		
	}
	
	# and output the results
	say qq[Output: ] . substr($result, 0, -2);
}
