#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Senior Citizens

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given a list of passenger details in the form “9999999999A1122”, where 9 denotes the phone number, A the sex, 1 the age and 2 the seat number.

Write a script to return the count of all senior citizens (age >= 60).

=head3 Example 1:

Input: @list = ("7868190130M7522","5303914400F9211","9273338290F4010")
Ouput: 2

The age of the passengers in the given list are 75, 92 and 40.
So we have only 2 senior citizens.

=head3 Example 2:

Input: @list = ("1313579440F2036","2921522980M5644")
Ouput: 0

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub number-of-senior-citizens(@_) {
    @_.grep(/^ \d ** 10 \D (\d\d) <?{$0 ≥ 60}> \d ** 2 $/).elems
} # end of sub my-sub ()

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => ("7868190130M7522","5303914400F9211","9273338290F4010"), output => 2, text => 'The age of the passengers in the given list are 75, 92 and 40, so we have only 2 senior citizens' },
        %{ input => ("1313579440F2036","2921522980M5644"), output => 0, text => 'The age of the passengers in the given list are 20 and 56, so we have no senior citizens' },
    ];

    for @tests {
        is-deeply number-of-senior-citizens( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (:$test! )


