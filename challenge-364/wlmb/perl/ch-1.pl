#!/usr/bin/env perl
# Perl weekly challenge 364
# Task 1:  Decrypt String
#
# See https://wlmb.github.io/2026/03/08/PWC364/#task-1-decrypt-string
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to decrypt the strings Sn, mapping
    10# to 26# into j..z and 1 to 9 into a..i
    FIN
my %map;
@map{(1..9), (map "$_\#", 10..26)} = ("a".."z");
for(@ARGV){
    try {
	my $in=$_;
	die "Invalid code: $in" unless /^(\d|\#)*$/; # only digits and hash marks
	s/(\d\d\#)(?{defined $map{$1}||die "Invalid code: $in"})/$map{$1}/eg;
	s/(\d)/$map{$1}/eg;
	die "Invalid code: $in" unless /^[a-z]*$/; # everything converted
	say "$in -> $_"
    }
    catch($e){ warn $e; }
}
