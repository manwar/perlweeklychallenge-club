#!/usr/bin/env perl
# Perl weekly challenge 207
# Task 1:  Keyboard Word
#
# See https://wlmb.github.io/2023/03/06/PWC207/#task-1-keyboard-word
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 [W2...]
    to find which of the words W1 W2... may be written using a single keyboard row.
    FIN
say join " ", @ARGV, "->",
    grep {/^([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$/i} @ARGV;
