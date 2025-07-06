#!/usr/bin/env perl
# Perl weekly challenge 328
# Task 2:  Good String
#
# See https://wlmb.github.io/2025/07/03/PWC328/#task-2-good-string
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to convert the strings S1 S2... into good strings
    without any lowercase (uppercase) letter adjacent to the corresponding
    uppercase (lowercase) letter.
    FIN
for(@ARGV){
    my $in=$_;
    1 while(s/([[:alpha:]])(??{my $l=lc($1); $l eq $1? uc($1):lc($1)})//);
    say"$in->$_";
}
