#!/usr/bin/env perl
# Perl weekly challenge 387
# Task 2:  Chemical formulae
#
# See https://wlmb.github.io/2026/08/17/PWC387/#task-2-chemical-formulae
use v5.36;
use Text::Balanced qw(extract_bracketed);
use feature qw(try);

die <<~"FIN" unless @ARGV;
    Usage: $0 F0 F1...
    to parse and simplify the chemical formula Fn removing
    parenthesis
    FIN
for(@ARGV){
    try{
	my %composition = parse($_, ());
	$composition{$_}=""
	    for grep {$composition{$_}==1} keys %composition;
	say "$_ -> ",
	    map {($_, $composition{$_})} sort keys %composition
    }
    catch($e){warn "Error in $_: $e"}
}

sub parse($formula, %current){
    for($formula){
	while($_){
	    my $start=$_;
	    $current{$1} += $2||1
		if s/^([A-Z][a-z]*)(\d*)//; #found element
	    my ($subformula, $rest)=extract_bracketed;
	    if($subformula){
		my %subcomposition =
		    parse(substr($subformula,1,
				 length($subformula)-2), ());
		$rest=~s/^(\d)*//;
		my $multiplier = $1 || 1;
		$current{$_} += $multiplier * $subcomposition{$_}
		    for keys %subcomposition;
		$_ = $rest; # update topic
	    }
	    die "Malformed formula: $_" if $_ eq $start; # avoid infinite loop
        }
    }
    return %current;
}
