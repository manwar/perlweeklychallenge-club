#!/usr/bin/env perl
# Perl weekly challenge 321
# Task 2:  Backspace Compare
#
# See https://wlmb.github.io/2025/05/12/PWC321/#task-2-backspace-compare
use v5.36;
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 A1 B1 A2 B2...
    to find if strings An Bn are equal after all \#'s are
    interpreted as backspace and applied to delete the preceding
    character.
    FIN
for my($x, $y)(@ARGV){
    my ($x_edited, $y_edited) = ($x, $y);   # make a copy
    ($x_edited, $y_edited) = map {
        1 while s/(^|[^\#])\#//g;           # apply backspaces. Deal with # at beginning
        $_;                                 # return edited string
    } ($x_edited, $y_edited);
    my $result = $x_edited eq $y_edited? "True" : "False";
    say "$x $y -> $result";
}
