#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/388/1

use v5.26;    # The Weekly Challenge - 2026-08-24
use utf8;     # Week 388 - task 1 - Dyck words
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

my ($n, %solutions);

dyck_words(6);

sub dyck_words {
	$n = $_[0];
	add_next('U', 1, 0);
	say qq[\nInput:  \$n = $n];
	say q[Output: ] . join(', ', sort keys %solutions) .
		q[ (] . (scalar keys %solutions) . q[)];
}

sub add_next {
	
	my ($word, $used_Us, $used_Ds);
	
	# initialise
	($word, $used_Us, $used_Ds) = @_;
	
	# check for solution
	if ($used_Ds == $n and $used_Us == $n) {
		$solutions{$word} = 1;
		return;
	}
	
	# can add a U
	if ($used_Us < $n) {
		add_next($word . 'U', $used_Us + 1, $used_Ds + 0);
	}
	
	# can add a D
	if ($used_Ds < $used_Us) {
		add_next($word . 'D', $used_Us + 0, $used_Ds + 1);
	}
}
