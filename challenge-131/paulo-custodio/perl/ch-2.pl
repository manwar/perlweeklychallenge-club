#!/usr/bin/env perl

# Challenge 131
#
# TASK #2 > Find Pairs
# Submitted by: Yary
# You are given a string of delimiter pairs and a string to search.
#
# Write a script to return two strings, the first with any characters
# matching the "opening character" set, the second with any matching
# the "closing character" set.
#
# Example 1:
# Input:
#     Delimiter pairs: ""[]()
#     Search String: "I like (parens) and the Apple ][+" they said.
#
# Output:
#     "(["
#     ")]"
# Example 2:
# Input:
#     Delimiter pairs: **//<>
#     Search String: /* This is a comment (in some languages) */ <could be a tag>
#
# Output:
#     /**/<
#     /**/>

use Modern::Perl;

my $delims = <>;
my $string = <>;

my $open_delims  = "[";
my $close_delims = "[";
while (length($delims) >= 2) {
    $open_delims  .= "\\".substr($delims,0,1);
    $close_delims .= "\\".substr($delims,1,1);
    $delims = substr($delims,2);
}
$open_delims  .= "]";
$close_delims .= "]";

my $open_string;
my $close_string;
for my $c (split //, $string) {
    $open_string  .= $c if $c =~ /$open_delims/;
    $close_string .= $c if $c =~ /$close_delims/;
}

say $open_string;
say $close_string;
