#!/usr/bin/env perl
# Perl weekly challenge 094
# Task 1: Group anagrams.
# From a list of strings recognize anagrams and group them.
# See https://wlmb.github.io/2021/01/04/PWC94/#task-1-group-anagrams
use v5.12;
my %anagrams;
push @{$anagrams{join '', sort split '', $_}}, $_ foreach @ARGV;
say join(" ", @{$anagrams{$_}})foreach keys %anagrams;
