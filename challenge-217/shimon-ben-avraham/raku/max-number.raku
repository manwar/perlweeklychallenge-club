#! /usr/bin/env raku

# Perl Weekly Challenge 217-2
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:13:54 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Max Number

=SUBTITLE
=head2 Submitted by: Mohammad S Anwar

=CHALLENGE
=head2
You are given a list of positive integers.
Write a script to concatenate the integers to form the highest possible value.

=head3 Example 1:

    Input: @list = (1, 23)

    Output: 231

=head3 Example 2:

    Input: @list = (10, 3, 2)

    Output: 3210

=head3 Example 3:

    Input: @list = (31, 2, 4, 10)

    Output: 431210

=head3 Example 4:

    Input: @list = (5, 11, 4, 1, 2)

    Output: 542111

=head3 Example 5:

    Input: @list = (1, 10)

    Output: 110

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub max-number (@list where .all ~~ UInt) {
   my UInt $retval = 0; 

   return $retval
} # end of sub max-number (UInt @list)

multi MAIN (:$test! ) {
    use Test;

    my @tests = [
        %{ input => (1, 23),          output => 231,    text => 'Example 1' },
        %{ input => (10, 3, 2),       output => 3210,   text => 'Example 2' },
        %{ input => (31, 2, 4, 10),   output => 431210, text => 'Example 3' },
        %{ input => (5, 11, 4, 1, 2), output => 542111, text => 'Example 4' },
        %{ input => (1, 10),          output => 110,    text => 'Example 5' },
    ];

    for @tests {
        is max-number( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )


