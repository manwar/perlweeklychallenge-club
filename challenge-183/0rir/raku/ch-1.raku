#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 183-1: Unique Array    Submitted by: Mohammad S Anwar
Given a list of arrays remove the duplicate arrays from the given list.
Example:
Input: @list = ([9,1], [3,7], [2,5], [2,5])
Output: ([9, 1], [3,7], [2,5])
=end comment

sub MAIN( @list = ([1,2], [3,4], [5,6], [1,2])) {
   say "Input: \@list = @list.raku()";
   say "Output: ", @list.unique( :with( &[eqv])).List.raku;
}
