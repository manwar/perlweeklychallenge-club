#!/usr/bin/env perl

# Challenge 045
#
# TASK #2
# Source Dumper
# Write a script that dumps its own source code. For example, say, the script
# name is ch-2.pl then the following command should returns nothing.
#
# $ perl ch-2.pl | diff - ch-2.pl

use Modern::Perl;

@ARGV = ($0);
print <>;
