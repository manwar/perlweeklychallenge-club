#!/usr/bin/env perl
# Perl weekly challenge 315
# Task 1:  Find Words
#
# See https://wlmb.github.io/2025/03/31/PWC315/#task-1-find-words
use v5.36;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 C W0 W1...
    to find the indices of the words Wn that contain the character C
    FIN
my $char = shift;
die "Expected a single char" unless $char=~/^\w$/;
say "char: $char, words: @ARGV -> ",
    join ",",
        map {$_->[0]}        # Extract indices
        grep {$_->[1]=~/$char/} # Test word
        map{[$_, $ARGV[$_]]}    # Schwartzian transform
        0..@ARGV-1;
