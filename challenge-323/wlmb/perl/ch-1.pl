#!/usr/bin/env perl
# Perl weekly challenge 323
# Task 1:
#
# See https://wlmb.github.io/2025/05/26/PWC323/#task-1-
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 E1 E2...
    to apply increment and decrement expressions ~En~
    of the form ++x, x++ --x, x--
    where x is the name of a variable
    FIN
my %vars;
for(@ARGV){
    $vars{$1}//=0, $vars{$1}++, next if /^\+\+([[:alpha:]]+)$/;
    $vars{$1}//=0, $vars{$1}--, next if /^--([[:alpha:]]+)$/;
    $vars{$1}//=0, $vars{$1}++, next if /^([[:alpha:]]+)\+\+$/;
    $vars{$1}//=0, $vars{$1}--, next if /^([[:alpha:]]+)--$/;
    die "Wrong format: $_";
}
print "@ARGV -> ";
print "$_=$vars{$_} " for keys %vars;
print "\n";
