#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge

use v5.26;    # The Weekly Challenge - 2025-04-14
use utf8;     # Week 317 - task 1 - Acronyms
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

acronyms([qw(produces every result lovingly)], 'perl');
acronyms([qw(this one is not true)], 'false');
acronyms([qw(true results usually exist)], 'true');
acronyms([qw(Port of London Authority River Information System)], 'POLARIS');

sub acronyms {
	
	my ($input, @words, $acronym, $concat);

	# intialise
	@words = @{$_[0]};
	$acronym = $_[1];
	
	# generate acronym from words
	$concat .= substr($words[$_], 0, 1) for 0 .. $#words;

	# report result
	say qq[\nInput:  \@words = ('] . join(q[', '], @words) . qq['), \$acronym = '$acronym'];
	say qq[Output: ] . (lc($concat) eq lc($acronym) ? 'true' : 'false');
}
