#! /usr/bin/env raku
use v6.d;

#===============================================================================
#
#         FILE: <.raku>
#
#  DESCRIPTION:
#
#       AUTHOR: Shimon Bollinger  (deoac.shimon@gmail.com)
#     REVISION: Last modified: Tue 25 Apr 2023 10:08:36 PM EDT
#===============================================================================

=begin comment
    Task 1: Rank Score
    Submitted by: Mohammad S Anwar
    You are given a list of scores (>=1).

    Write a script to rank each score in descending order. First three will get medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking number.

    Using the standard model of giving equal scores equal rank, then advancing that number of ranks.


    Example 1
    Input: @scores = (1,2,4,3,5)
    Output: (5,4,S,B,G)

    Score 1 is the 5th rank.
    Score 2 is the 4th rank.
    Score 4 is the 2nd rank i.e. Silver (S).
    Score 3 is the 3rd rank i.e. Bronze (B).
    Score 5 is the 1st rank i.e. Gold (G).
    Example 2
    Input: @scores = (8,5,6,7,4)
    Output: (G,4,B,S,5)

    Score 8 is the 1st rank i.e. Gold (G).
    Score 4 is the 4th rank.
    Score 6 is the 3rd rank i.e. Bronze (B).
    Score 7 is the 2nd rank i.e. Silver (S).
    Score 4 is the 5th rank.
    Example 3
    Input: @list = (3,5,4,2)
    Output: (B,G,S,4)
    Example 4
    Input: @scores = (2,5,2,1,7,5,1)
    Output: (4,S,4,6,G,S,6)
=end comment
