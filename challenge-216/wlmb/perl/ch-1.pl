#!/usr/bin/env perl
# Perl weekly challenge 216
# Task 1:  Registration Number
#
# See https://wlmb.github.io/2023/05/08/PWC216/#task-1-registration-number
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 R W1 [W2...]
    to select the words Wn that contain all the letters in the
    registration number R.
    FIN
my $reg=shift;
my @words=@ARGV;
my @letters_reg=grep {/[a-z]/} split "", lc $reg;
my @result=grep
{
    my %letters;
    map {$letters{$_}=1} split "", lc $_;
    all {$letters{$_}} @letters_reg
} @words;
say "Registration number: $reg, words: @words, output: @result";
