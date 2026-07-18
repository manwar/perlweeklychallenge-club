#!/usr/bin/env perl
# Perl weekly challenge 382
# Task 2:  Replace Question Mark
#
# See https://wlmb.github.io/2026/07/13/PWC382/#task-2-replace-question-mark
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to substitute the each question mark (?) by 0 and by 1
    in the strings Sn.
    FIN
for(@ARGV){
    try {
	die "Only 1, 0 and ? are allowed: $_" unless /^[01\?]*$/;
	say "$_ -> (", join(" ", replace($_)), ")";
    }
    catch($e){warn $e}
}
sub replace ($s){
    for($s){
	return ($_) unless /\?/;
	return (replace(s/\?/0/r), replace(s/\?/1/r));
    }
}
