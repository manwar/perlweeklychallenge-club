#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin comment
Task 182--1: Max Index Submitted by: Mohammad S Anwar
Given a list of integers, find the index of the first biggest number in it.

Example
Input: @n = (5, 2, 9, 1, 7, 6)
Output: 2 (as 3rd element in the list is the biggest number)
=end comment

sub MAIN(@n = (4,2,3,1,5,0) ) {

    my $pos = @n.first( @n.max, :k);

    say "Input: \@n = ( {@n.join( ', ')})\n"
      ~ "Output: $pos (as element {$pos+1} is the the biggest number)";
}

