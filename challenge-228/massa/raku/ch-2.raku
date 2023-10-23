#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Empty Array

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers in which all elements are unique.

Write a script to perform the following operations until the array is empty and
return the total count of operations.

    If the first element is the smallest then remove it otherwise move it to
    the end.

=head3 Example 1:

    Input: @int = (3, 4, 2)
    Ouput: 5

    Operation 1: move 3 to the end: (4, 2, 3)
    Operation 2: move 4 to the end: (2, 3, 4)
    Operation 3: remove element 2: (3, 4)
    Operation 4: remove element 3: (4)
    Operation 5: remove element 4: ()

=head3 Example 2:

    Input: @int = (1, 2, 3)
    Ouput: 3

    Operation 1: remove element 1: (2, 3)
    Operation 2: remove element 2: (3)
    Operation 3: remove element 3: ()

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub empty-array(@_) {
  + (@_, -> @ [$head, *@tail] { $head ≤ @tail.all ?? @tail !! [|@tail, $head] } ... * ≤ 1)
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (3, 4, 2), output => 5 },
        %{ input => (1, 2, 3), output => 3 },
    ];

    for @tests {
        empty-array( .<input> ).&is-deeply: .<output>, .<text>;

    } # end of for @tests
} # end of multi MAIN (:$test!)


