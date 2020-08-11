#!/usr/bin/perl

# Create a script that accepts one or more files specified on the command-line and count the number of times letters appeared in the files.

# Input file sample.txt -> The quick brown fox jumps over the lazy dog.

use strict;
use warnings;

die "Please indicate a file" unless @ARGV; # we ignore STDIN in case no file is indicated

my %count = ();

# loops through files, then lines, then characters
map { $count{lc $_}++} grep { /[a-z]/i } split "",  <<>>;

printf "%s: %s\n",$_,$count{$_} for sort keys %count;
