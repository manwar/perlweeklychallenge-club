#!/usr/bin/env raku
use v6;

sub circular(@list) {
  while (@list.elems > 1) {
    # get the last letter of the first element 
    my $last  = ( @list[0].comb )[*-1];
    # and the first letter of the second element
    my $first = ( @list[1].comb )[0];
    # if they don't match case-insensitively, return false
    return False if $last.lc ne $first.lc;
    # remove the first element from the list
    @list.pop;
  }
  return True; # we got through all the elements
}

sub solution(@arr) {
  say 'Input: @arr = ("' ~ @arr.join('", "') ~ '")';
  say 'Output: ' ~ circular(@arr);
}

say "Example 1:";
solution(["perl", "loves", "scala"]);

say "\nExample 2:";
solution(["love", "the", "programming"]);

say "\nExample 3:";
solution(["java", "awk", "kotlin", "node.js"]);
