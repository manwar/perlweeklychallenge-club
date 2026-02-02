#!/usr/bin/env perl
# Perl weekly challenge 359
# Task 1:  Digital Root
#
# See https://wlmb.github.io/2026/02/02/PWC359/#task-1-digital-root
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find the persistence and digital root of the numbers Nm
    FIN
use List::Util qw(sum0);
for(@ARGV){
    try {
	die "Only digits allowed: $_" unless /^\d+$/;
	my $root = $_;
	my $persistence = 0;
	++$persistence, $root=sum0 split "", $root while $root>9;
	say "$_ -> persistence=$persistence, root=$root";
    }
    catch($e){ warn $e };
}
