#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Duplicate Zeros

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers.

Write a script to duplicate each occurrence of ZERO in the given array and
shift the remaining to the right but make sure the size of array remain the
same.

=head3 Example 1:

Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Ouput: (1, 0, 0, 2, 3, 0, 0, 4)

=head3 Example 2:

Input: @ints = (1, 2, 3)
Ouput: (1, 2, 3)

=head3 Example 3:

Input: @ints = (0, 3, 0, 4, 5)
Ouput: (0, 0, 3, 0, 0)

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub duplicate-zeros(@_) {
  @_.map(* || |(0, 0)).head: +@_
}
# there is a regex-based solution I love but I understand other ppl will hate:
# S:g/<|w>0<|w>/0 0/.words.head: +@x given ~@x

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (1, 0, 2, 3, 0, 4, 5, 0), output => (1, 0, 0, 2, 3, 0, 0, 4) },
        %{ input => (1, 2, 3),                output => (1, 2, 3) },
        %{ input => (0, 3, 0, 4, 5),          output => (0, 0, 3, 0, 0) },
    ];

    for @tests {
        duplicate-zeros( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test!)


