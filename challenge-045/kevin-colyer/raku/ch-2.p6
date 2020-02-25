#!/usr/bin/perl6
use v6;

=begin pod

TASK #2
Source Dumper
Write a script that dumps its own source code. For example, say, the script name is ch-2.pl then the following command should returns nothing.

$ perl ch-2.pl | diff - ch-2.pl


=end pod

# $*PROGRAM has the IO.Path object of the program. I use print as this keeps the same number
# of new lines as in the source (.say would add an extra one)
slurp($*PROGRAM).print;

