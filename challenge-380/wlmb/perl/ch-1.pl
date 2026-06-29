#!/usr/bin/env perl
# Perl weekly challenge 380
# Task 1:  Sum of Frequencies
#
# See https://wlmb.github.io/2026/06/29/PWC380/#task-1-sum-of-frequencies
use v5.36;
use feature qw(try);
use List::Util qw(max);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to sum the frequencies of the most frequent vowel and
    consonant in string Sn.
    FIN
my @vowels = qw(a e i o u);
for(@ARGV){
    my $lc = lc $_;
    try {
	die "Expected English letters only: $_" unless $lc=~/^[a-z]*$/;
	my %count;
	@count{'a'..'z'}=(0) x 26;
	$count{$_}++ for split "", $lc;
	my $vowels = max @count{@vowels};
	delete @count{@vowels};
	my $consonants=max values %count;
	my $sum = $vowels + $consonants;
	say "$_ -> $sum";
    }
    catch($e){ warn $e; }
}
