#!/usr/bin/env perl
# Perl weekly challenge 345
# Task 1:  Peak Positions
#
# See https://wlmb.github.io/2025/10/27/PWC345/#task-1-peak-positions
use v5.36;
use feature qw(try);
use PDL;
use PDL::NiceSlice;

die <<~"FIN" unless @ARGV;
    Usage: $0 A0 A1...
    to find the local maxima of the arrays An,
    given by strings of the form
    "[X0 X1...]" that may be parsed by PDL.
    FIN
for(@ARGV){
    try {
	my $ints=pdl($_);
	# pad with smaller numbers at boundaries
	my $padded=append(append($ints(0)-1, $ints), $ints(-1)-1);
	my $indices=which(($padded>$padded->rotate(1))&($padded>$padded->rotate(-1)));
	$indices -= 1; # remove left boundaries
	say "$_ -> $indices";
    }
    catch($e){warn $e;}
}
