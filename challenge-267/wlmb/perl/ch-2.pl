#!/usr/bin/env perl
# Perl weekly challenge 267
# Task 2:  Line Counts
#
# See https://wlmb.github.io/2024/04/29/PWC267/#task-2-line-counts
use v5.36;
die <<~"FIN" unless @ARGV==27;
    Usage: $0 S W1 W2...W26
    to find how many lines and additional characters are needed to print
    the string S given the widths W1, W2..W26 of the letters a, b...z.
    FIN

my $line_width=100;
my $string=shift;
my @widths_ord=@ARGV;
my @widths_string=map {$widths_ord[ord($_)-ord("a")]} split "", $string;
my $current_line=1; # Note that I report one line, 0 chars for an empty string!
my $current_column = 0; # current column
for(@widths_string){
    $current_column += $_;
    $current_column = $_, ++$current_line if $current_column > $line_width;
    $current_column = 0, ++$current_line if $current_column == $line_width;

}
say "string=$string\nwidths=\n\t@widths_ord[0..9]\n\t@widths_ord[10..19]",
    "\n\t@widths_ord[20..25]\n ->  ($current_line, $current_column)";
