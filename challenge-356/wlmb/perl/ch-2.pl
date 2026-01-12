#!/usr/bin/env perl
# Perl weekly challenge 356
# Task 2:  Who Wins
#
# See https://wlmb.github.io/2026/01/12/PWC356/#task-2-who-wins
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 R0 R1...
    to determine the winner given the results Rn.
    Each Rn is a string of six letters, each an A or H
    meaning the corresponding game was won by the away
    or the home team.
    FIN
sub winner($l,$g){$l=~/H/?$g->[0]:$g->[1]}
sub loser($l,$g){$l=~/H/?$g->[1]:$g->[0]}
for(@ARGV){
    try {
	die "Wrong format $_: expected a string of 6 A|H" unless /^(A|H){6}$/;
	my @results=split "";
	my @games=([2,7],[3,6],[4,5]);
	my @winners=sort {$a <=> $b} map{winner($results[$_], $games[$_])}0..2;
	push @games, [1,$winners[2]], [$winners[0], $winners[1]];
	@winners=sort{$a <=> $b} map{winner($results[$_], $games[$_])}3,4;
	my $last=[@winners[0,1]];
	say "$_ -> Team  ", winner($results[5], $last), " defeated Team ", loser($results[5], $last);
    }
    catch($e){warn $e; }
}
