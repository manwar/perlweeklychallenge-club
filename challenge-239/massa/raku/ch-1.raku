#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Same String

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given two arrays of strings.

Write a script to find out if the word created by concatenating the array
elements is the same.

=head3 Example 1:

Input: @arr1 = ("ab", "c")
       @arr2 = ("a", "bc")
Output: true

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "a" . "bc" => "abc"

=head3 Example 2:

Input: @arr1 = ("ab", "c")
       @arr2 = ("ac", "b")
Output: false

Using @arr1, word1 => "ab" . "c" => "abc"
Using @arr2, word2 => "ac" . "b" => "acb"

=head3 Example 3:

Input: @arr1 = ("ab", "cd", "e")
       @arr2 = ("abcde")
Output: true

Using @arr1, word1 => "ab" . "cd" . "e" => "abcde"
Using @arr2, word2 => "abcde"

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub same-string(@_) {
  @_[0].join eq @_[1].join
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (<ab c>, <a bc>),     output => True },
        %{ input => (<ab c>, <ac b>),     output => False },
        %{ input => (<ab cd e>, <abcde>), output => True },
    ];

    for @tests {
        same-string( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (Bool :$test!)


