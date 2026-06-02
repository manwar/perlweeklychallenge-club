#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-376/#TASK2
#
# Task 2: Doubled Words
# =====================
#
# You are given a string (which may contain embedded newlines) which is taken
# from a page on a website. The string will not contain brackets qw{ [ ] }.
#
# Write a script that will find doubled words (such as “this this”) and
# highlight (wrap in brackets) each doubled word.
#
# The script should:
#
#   - Work across lines, even finding situations where a word at the end of
#     one line is repeated at the beginning of the next.
#
#   - Find doubled words despite capitalization differences, such as with
#     'The the...', as well as allow differing amounts of whitespace (spaces,
#     tabs, newlines, and the like) to lie between the words.
#
#   - Find doubled words even when separated by HTML tags. For example, to
#     make a word bold: '...it is <B>very</B> very important...'. Only show
#     lines containing doubled words.
#
# Example 1
#
# Input: $str = "you're given the job of checking the pages on a\nweb server
# for doubled words (such as 'this this'), a common problem\nwith documents
# subject to heavy editing."
# Output: "web server for doubled words (such as '[this] [this]'), a common problem"
#
# Example 2
#
# Input: $str = "Find doubled words despite capitalization differences, such as
# with 'The\nthe...', as well as allow differing amounts of whitespace
# (spaces,\ntabs, newlines, and the like) to lie between the words."
# Output: "Find doubled words despite capitalization differences, such as with
# '[The]\n[the]...', as well as allow differing amounts of whitespace (spaces,"
#
# Example 3
#
# Input: $str = "to make a word bold: '...it is <B>very</B> very important...'."
# Output: "to make a word bold: '...it is <B>[very]</B> [very] important...'."
#
# Example 4
#
# Input: $str = "Perl officially stands for Practical Extraction and Report
# Language, except when it doesn't."
# Output: ""
#
# Example 5
#
# Input: $str = "There's more than one one way to do it.\nEasy things should be
# easy and hard things should be possible."
# Output: "There's more than [one] [one] way to do it."
#
############################################################
##
## discussion
##
############################################################
#
# This is a fun regex one. We capture the first word, make sure there is nothing else
# than whitespace or HTML tags between it and the next word, and the next word matches
# the first one as well. We replace all of that by whatever we captured (both the words
# and the stuff between them) with the same stuff, but the words are inside [ and ].
# For the output we just need to add a little magic to only print actual result lines.

use v5.36;

doubled_words("you're given the job of checking the pages on a
web server for doubled words (such as 'this this'), a common problem
with documents subject to heavy editing.");
doubled_words("Find doubled words despite capitalization differences, such as with 'The
the...', as well as allow differing amounts of whitespace (spaces,
tabs, newlines, and the like) to lie between the words.");
doubled_words("to make a word bold: '...it is <B>very</B> very important...'.");
doubled_words("Perl officially stands for Practical Extraction and Report Language, except when it doesn't.");
doubled_words("There's more than one one way to do it.
Easy things should be easy and hard things should be possible.");

sub doubled_words($str) {
    say "Input: \"$str\"";
    $str =~ s/(\b\w+\b)((\s+|<[^>]*>)*)(\1)/[$1]$2\[$4]/gis;
    my @lines = split /\n/, $str;
    print "Output: \"";
    my $printed = 0;
    foreach my $line (@lines) {
        if($line =~ m/\[/) {
            print "\n" if $printed;
            print $line;
            $printed = 1;
        }
    }
    say "\"";
}
