#!/usr/bin/env perl
# Perl weekly challenge 209
# Task 1:  Special Bit Characters
#
# See https://wlmb.github.io/2023/03/20/PWC209/#task-1-special-bit-characters
use v5.36;
my %patterns;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to decode the binary sequences S1 S2
    using the code 0->a, 10->b 11->c
    FIN

@patterns{qw(0 10 11)}=qw(a b c);
for(@ARGV){
    my $last;
    die "Not a binary pattern: $_\n" unless /^(0|1)+/; #Check input
    say " $_ -> ",
        (
	 map {$last=$patterns{$_}}
	 grep {length $_}
	 split /(1.|0)/
	),
	" -> ",
	$last eq "a"?1:0;
}
