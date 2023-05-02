#!/usr/bin/env perl
# Perl weekly challenge 215
# Task 2:  Number Placement
#
# See https://wlmb.github.io/2023/05/01/PWC215/#task-2-number-placement
use v5.36;
die <<~"FIN" unless @ARGV==2;
    Usage: $0 N S
    to find if I can replace N 1's in the string S consisting of 0's and 1's
    Only 0's that don't have a 1 to their left nor right may be replaced.
    FIN
my $count=shift;
my $copy=my $orig=shift;
for($copy){ # localize
    die "Only 0's and 1's allowed. Invalid input: $_" unless /^[01]*$/;
    s/^/0/; # add leading and trailing 0's
    s/$/0/;
    my $replacements=0;
    $replacements++ while s/000/010/; # count replacements
    say "Count: $count, string: $orig -> ", $replacements>=$count? 1:0;
}
