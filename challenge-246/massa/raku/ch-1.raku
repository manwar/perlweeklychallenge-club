#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: 6 out of 49

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

6 out of 49 is a German lottery.

Write a script that outputs six unique random integers from the range 1 to 49.

=head3 Example 1:

   Input: @lang = ('perl', 'c', 'python')
          @popularity = (2, 1, 3)
   Output: ('c', 'perl', 'python')=head3 Example 2:

=head3 Example 3:

   Input: @lang = ('c++', 'haskell', 'java')
          @popularity = (1, 3, 2)
   Output: ('c++', 'java', 'haskell')

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION() {
    (1..49).pick: 6
}

multi MAIN (Bool :$test!) {
    use Test;

    SOLUTION.&{ .note; $_ }.&{ is .elems, 6; ok .combinations(2).map({[==] $_}).none.so } for ^3;
} # end of multi MAIN (Bool :$test!)


