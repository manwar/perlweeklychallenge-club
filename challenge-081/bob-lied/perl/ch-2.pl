#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl
#=============================================================================
# Copyright (c) 2020, Bob Lied
#=============================================================================
# Perl Weekly Challenge 081 Task #2 > Frequency Sort
#=============================================================================
# You are given file named input.
# Write a script to find the frequency of all the words.
# It should print the result as first column of each line should be the
# frequency of the the word followed by all the words of that frequency
# arranged in lexicographical order. Also sort the words in the ascending
# order of frequency.
# For the sake of this task, please ignore the following in the input file:
#   . " ( ) , 's --
# Keep hyphenated words and contractions, but reduce possessives to their base
# (e.g., "award-winning" and "doesn't" are words, but "Joe's" becomes "Joe"

use strict;
use warnings;
use v5.30;

use feature qw/ signatures /;
no warnings qw/ experimental::signatures /;

use Getopt::Long;

use lib "lib";
use FrequencySort;

sub Usage { "Usage: $0 args" };

my $Verbose = 0;
GetOptions('verbose' => \$Verbose);

my $arg = shift;
my @list = @ARGV;

die Usage() unless $arg;
die Usage() unless @list;

my $task = FrequencySort->new();
my $result = $task->run();
say $result;
