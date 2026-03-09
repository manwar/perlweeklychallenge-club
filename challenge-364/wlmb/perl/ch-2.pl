#!/usr/bin/env perl
# Perl weekly challenge 364
# Task 2:  Goal Parser
#
# See https://wlmb.github.io/2026/03/08/PWC364/#task-2-goal-parser
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to parse the strings Sn with the Goal Parser.
    FIN
for(@ARGV){
    try{
	my $in=$_;
	die "Wrong format: $in" unless /^(G|\(\)|\(al\))*$/;
	s/\(\)/o/g;
	s/\(al\)/al/g;
	say "$in -> $_ ";
    }
    catch($e){ warn $e }
}
