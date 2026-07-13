#!/usr/bin/env perl
# Perl weekly challenge 382
# Task 1:  Hamiltonian Cycle
#
# See https://wlmb.github.io/2026/07/13/PWC382/#task-1-hamiltonian-cycle
use v5.40;
use feature qw(try);
use Scalar::Util qw(looks_like_number);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to build a Hamiltonian cycle that visits all numbers 1..Nn
    such that two consecutive numbers in the cycle add to a perfect square.
    FIN
for(@ARGV){
    try {
	die "Expected a number: $_"
	    unless looks_like_number $_;
	say"$_ -> (@{hamiltonian([1],[2..$_])||[]})"
    }
    catch($e){warn $e; }
}
sub hamiltonian($so_far, $rest){
    my $last=$so_far->[-1];
    return is_square($last + $so_far->[0])?
	$so_far : () unless @$rest; # all consumed
    for(0..@$rest-1){
	next unless is_square($last + $rest->[$_]);
	my $result =
	    hamiltonian(
		[@$so_far, $rest->[$_]],
		[@$rest[0..$_-1, $_+1..@$rest-1]]
	    );
	return $result if $result;
    }
    return 0;
}
sub is_square($x){
    $x==floor(sqrt($x))**2;
}
