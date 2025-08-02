#!/usr/bin/env perl
use v5.40;

sub circular(@list) {
  while (@list > 1) {
    # get the last letter of the first element 
    my $last  = ( split //, $list[0] )[-1];
    # and the first letter of the second element
    my $first = ( split //, $list[1] )[0];
    # if they don't match case-insensitively, return false
    return 'False' if lc($last) ne lc($first);
    # remove the first element from the list
    pop @list;
  }
  return 'True'; # we got through all the elements
}

sub solution(@arr) {
  say 'Input: @arr = ("' . join('", "', @arr) . '")';
  say 'Output: ' . circular(@arr);
}

say "Example 1:";
solution("perl", "loves", "scala");

say "\nExample 2:";
solution("love", "the", "programming");

say "\nExample 3:";
solution("java", "awk", "kotlin", "node.js");