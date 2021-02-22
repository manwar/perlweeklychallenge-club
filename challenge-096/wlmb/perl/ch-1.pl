#!/usr/bin/env perl
# Perl weekly challenge 096
# Task 1: Reverse words
# Print words in reverse order separated by one space
# Remove all non-word characters
# See https://wlmb.github.io/2021/01/18/PWC096/#task-1-reverse-words

use warnings;
use strict;
use v5.10;

say "\"", join(" ", grep $_, reverse split /\W+/, $_),"\"" foreach(@ARGV);
