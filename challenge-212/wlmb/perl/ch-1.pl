#!/usr/bin/env perl
# Perl weekly challenge 212
# Task 1:  Jumping Letters
#
# See https://wlmb.github.io/2023/04/10/PWC212/#task-1-jumping-letters
use v5.36;

die <<~"FIN" unless @ARGV;
    Usage: $0 word J1 [J2...]
    Replace word after jumping its first J1 positions, its second letter
    J2  positions and so on.
    FIN

my @letters="a".."z";
my %index_of;
my $counter=0;
$index_of{$_}=$counter++ for @letters;

my @input=split "", my $input=shift;
my @jumps=@ARGV;
die "Expected as many jumps as letters" unless @input==@jumps;
my @output=
    map {
	my $output=$letters[($index_of{lc $input[$_]}+$jumps[$_])%@letters];
	$input[$_]=~/[A-Z]/?uc $output:$output
    } 0..@input-1;
my $output = join "", @output;
say "$input -> $output";
