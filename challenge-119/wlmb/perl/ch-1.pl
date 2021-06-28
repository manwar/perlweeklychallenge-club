#!/usr/bin/env perl
# Perl weekly challenge 119
# Task 1: Swap Nibbles
#
# See https://wlmb.github.io/2021/06/21/PWC119/#task-1-swap-nibbles


use strict;
use warnings;
use v5.32;

map {
    die "Keep to range 0-255" unless 0<=$_<=255;
    my $s=my $o=sprintf("%08b", $_);
    $s=~s/^(.{4})(.{4})$/$2$1/;
    say sprintf("Input: %s (%s), Output: %s(%s)", $_,$o, oct("0b$s"), $s)
} @ARGV;
