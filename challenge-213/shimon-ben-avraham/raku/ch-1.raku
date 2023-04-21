#! /usr/bin/env raku
use v6.d;

#===============================================================================
#
#         FILE: <ch-1.raku>
#
#  DESCRIPTION: A solution to the Perl Weekly Challenge 213, Challenge 1
#
#       AUTHOR: Shimon Bollinger  (deoac.shimon@gmail.com)
#     REVISION: Last modified: Fri 21 Apr 2023 03:18:29 PM EDT
#===============================================================================

=begin comment
    Task 1: Fun Sort
    Submitted by: Mohammad S Anwar
    You are given a list of positive integers.

    Write a script to sort the all even integers first 
    then all odds in ascending order.

    Example 1
    Input: @list = (1,2,3,4,5,6)
    Output: (2,4,6,1,3,5)
    Example 2
    Input: @list = (1,2)
    Output: (2,1)
    Example 3
    Input: @list = (1)
    Output: (1)
=end comment

sub FunSort (@list) {
     return @list if @list.elems == 1;

     my %split  = @list.classify:{ $_ %% 2 ?? 'even' !! 'odd' };
     my @evens  = |%split<even>.sort;
     my @odds   = |%split<odd>.sort;
     my @retval = |@evens, |@odds;
} # end of sub MAIN (ℕ @list)

use Test;
my @list;

@list = (1,2,3,4,5,6);
ok FunSort(@list), (2,4,6,1,3,5);

@list = (1,2);
ok FunSort(@list), (2,1);

@list = (1);
ok FunSort(@list), (1);

@list = (1..^100).pick(50).grep: (* > 0);
say FunSort(@list);

