#!/usr/bin/env perl
# Perl weekly challenge 369
# Task 1:  Valid Tag
#
# See https://wlmb.github.io/2026/04/13/PWC369/#task-1-valid-tag
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to make a tag our of the strings Sn
    FIN
for(@ARGV){
    my $input = $_;
    s/^\s*//; # Remove leading spaces
    my ($first, @rest) = split " ";
    my $joined = join " ",
	lc($first),
	map {ucfirst} @rest;
    $joined =~ tr/a-zA-Z//cd; # remove non-English letters
    my $result= substr
	"#$joined",  # append hash
	0, 100; # and truncate
    say "$input -> $result";
}
