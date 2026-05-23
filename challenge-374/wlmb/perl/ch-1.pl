#!/usr/bin/env perl
# Perl weekly challenge 374
# Task 1:  Count Vowel
#
# See https://wlmb.github.io/2026/05/22/PWC374/#task-1-count-vowel
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find all substrings of Sn containing only vowels, and all of them.
    FIN
for(@ARGV){
    try{
	die "Expected a lowercase string: $_" unless $_ eq lc $_;
	my @results;
	for my $noconsonant(/([aeiou]+)/g){
	    my $maxlength = length $noconsonant;
	    for(0..$maxlength){
		# truncate from the start
		test(my $tentative = substr $noconsonant, $_) || last;
		push @results, $tentative;
		for(1..$maxlength){
		    # truncate from the end
		    test(my $truncated = substr $tentative, 0, -$_) || last;
		    push @results, $truncated;
		}
	    }
	}
	say "$_ -> (@results)";
    }
    catch($e){warn $e}
}
sub test($x){
    $x=~/$_/||return 0 for(split "","aeiou");
    return 1;
}
