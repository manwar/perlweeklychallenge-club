#!/usr/bin/env perl
# Perl weekly challenge 118
# Task 1: Binary palindrome
#
# See https://wlmb.github.io/2021/06/21/PWC118/#task-1-binary-palindrome


use strict;
use warnings;
use v5.12;

map {
    my $b=sprintf("%b", $_);
    say "Input: $_, Output: ", ($b eq reverse $b)?1:0
} @ARGV;
