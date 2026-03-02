#!/usr/bin/env perl
# Perl weekly challenge 363
# Task 1:  String Lie Detector
#
# See https://wlmb.github.io/2026/03/02/PWC363/#task-1-string-lie-detector
use v5.36;
use feature qw(try);
my @digit_names = qw(zero one two three four five six seven eight nine);
my %name_to_digit;
@name_to_digit{@digit_names} = (0..9);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to check if the string Sn correctly describes itself.
    Each string is of the form s - v vowels and c consonants,
    where s is a substring, - is a dash or em-dash, and v and c
    are number names in the range 0-9.
    FIN
for(@ARGV){
    try {
	die "Wrong format: $_"
	    unless /^\s*(.*?)\s*(-|—)\s*(.*)\s+vowels?\s+and\s+(.*)\s+consonants?$/;
	my ($string, $vocals, $consonants) = ($1, map {$name_to_digit{$_}} ($3,$4));
	my @vocals = $string=~/([aeiou])/g;
	my @consonants = $string=~/([^aeiou])/g;
	my $result = @vocals == $vocals && @consonants == $consonants;
	say "$_ -> ", $result?"True":"False";
    }
    catch($e){ warn $e }
}
