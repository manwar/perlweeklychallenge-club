#!/usr/bin/env perl
# Perl weekly challenge 358
# Task 2:  Encrypted String
#
# See https://wlmb.github.io/2026/01/26/PWC358/#task-2-encrypted-string
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 N0 S0 N1 S1...
    to shift the letters of the string Si by the integer Ni.
    FIN
my @letter = 'a'..'z';
my %index_of;
my $n=0;
$index_of{$_}=$n++ for @letter;
for my($int, $string)(@ARGV){
    say"$int $string -> ",
	join "",
	map {
	    my $upper=/[A-Z]/;
	    my $lower=/[a-z]/;
	    $upper? uc $letter[($index_of{lc $_} + $int) % @letter]
		: $lower? $letter[($index_of{$_} + $int) % @letter]
		: $_
        } split "", $string
}
