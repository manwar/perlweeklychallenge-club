#!usr/bin/perl
use v5.36;

# Challenge 230 - 2 - Count Words

# You are given an array of words made up of alphabetic characters and a prefix.
# Write a script to return the count of words that starts with the given prefix.


countWords("at", "pay", "attention", "practice", "attend");
countWords("ja", "janet", "julia", "java", "javascript");

sub countWords($prefix, @list)
{
    say scalar grep { /^$prefix/ } @list;
}