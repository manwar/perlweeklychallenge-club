#!/usr/bin/perl
use strict;
use warnings;
use v5.10;

# PWC 131 task 1 - Peter Campbell Smith - 2021-09-20

# You are given a sorted list of unique positive integers.
# Write a script to return list of arrays where the arrays are consecutive integers.

my ($delimiter_pairs, $search_string, $openers, $closers);

# loop over input values
until (eof(DATA)) {
    $delimiter_pairs = <DATA>;;
    $search_string = <DATA>;
    chop($delimiter_pairs, $search_string);
    do_task();
}

sub do_task {

    my ($openers, $closers, $opens, $closes);

    # copy the search string
    $openers = $closers = $search_string;

    # pick off the delimiters in pairs and make strings of the opening and closing characters
    while ($delimiter_pairs =~ m|(.)(.)|g) {
    	$opens .= $1;
    	$closes .= $2;
    }

    # remove all but the opening characters from $openers and similarly with $closers
    $openers =~ s|[^\Q$opens\E]||g;
    $closers =~ s|[^\Q$closes\E]||g;

    say qq[\nDelimiter pairs: $delimiter_pairs];
    say qq[Search string: $search_string];
    say qq[Openers: $openers];
    say qq[Closers: $closers];
}

__DATA__
""[]()
"I like (parens) and the Apple ][+" they said.
**//<>
/* This is a comment (in some languages) */ <could be a tag>
abcdef
Write a script to return two strings, the first with any characters matching the “opening character” set, the second with any matching the “closing character” set.
