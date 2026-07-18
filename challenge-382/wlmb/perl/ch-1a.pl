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
my %follower;
for my $in (@ARGV){
    try {
	die "Expected a number: $in"
	    unless looks_like_number $in;
	my @squares=map{$_**2}(2..floor(sqrt(2*$in-1)));
	for my $i(1..$in){
	    $follower{$i}=[grep {$_>0 && $_<=$in} map{$_-$i} @squares];
	}
	say "$in -> (@{hamiltonian([1],{1=>1}, $in-1)||[]})"
    }
    catch($e){warn $e; }
}

sub hamiltonian($so_far, $used, $count){
    my $last=$so_far->[-1];
    return (grep {$_==1} $follower{$last}->@*)? $so_far : () unless $count--;
    for($follower{$last}->@*){
        next if $used->{$_};
	my $result = hamiltonian(
		[@$so_far, $_],
		{%$used, $_=>1},
                $count
	    );
	return $result if $result;
    }
    return ();
}
