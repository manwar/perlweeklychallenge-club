#!/usr/bin/perl

# Blog: http://ccgi.campbellsmiths.force9.co.uk/challenge/385/2

use v5.26;    # The Weekly Challenge - 2026-08-03
use utf8;     # Week 385 - task 2 - Outermost parentheses
use warnings; # Peter Campbell Smith
binmode STDOUT, ':utf8';
use Encode;

outermost_parentheses('()()()');
outermost_parentheses('(((())))');
outermost_parentheses('(()())(())');
outermost_parentheses('()((()))()');
outermost_parentheses('(()(()))(()())');
outermost_parentheses('((())))');

sub outermost_parentheses {
	
	my (@parens, $depth, @decomp, $d, $m, $unbalanced, $output);
	
	# initialise
	say qq[\nInput:  '$_[0]'];
	@parens = split('', $_[0]);
	$depth = $d = 0;
	$output = '';
	
	# decompose
	for $m (@parens) {
		next unless $m =~ m|[()]|;
		$depth += ($m eq '(' ? 1 : -1);
		last if $depth < 0;
		$decomp[$d] .= $m;
		$d ++ if $depth == 0;
	}
	
	# check for balance
	if ($depth != 0) {
		say qq[Output: error - unbalanced parentheses];
		return;
	}
	
	# format output
	for $m (@decomp) {
		$m =~ m|^.(.*).$|;
		$output .= $1;
	}
	say qq[Output: '$output'];
	say qq[        Primitive decomposition = '] . 
		join(q[' + '], @decomp) . q['];
}
