#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 375 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Single Common Word

You are given two array of strings.

Write a script to return the number of strings that appear exactly once in each of the two given arrays. String comparison is case sensitive.

=head3 Example 1:

Input: @array1 = ("apple", "banana", "cherry")
       @array2 = ("banana", "cherry", "date")
Output: 2

=head3 Example 2:

Input: @array1 = ("a", "ab", "abc")
       @array2 = ("a", "a", "ab", "abc")
Output: 2

"a" appears once in @array1 but appears twice in @array2, therefore, not counted.

=head3 Example 3:

Input: @array1 = ("orange", "lemon")
       @array2 = ("grape", "melon")
Output: 0

=head3 Example 4:

Input: @array1 = ("test", "test", "demo")
       @array2 = ("test", "demo", "demo")
Output: 0

=head3 Example 5:

Input: @array1 = ("Hello", "world")
       @array2 = ("hello", "world")
Output: 1

String comparison is case sensitive.

=end pod

sub single-common-word(@array1, @array2, --> Int) {
    ((@array1 (-) @array1.repeated) (&) (@array2 (-) @array2.repeated)).elems;
}

#| count the single common words in comma separated array1 and array2
multi MAIN(Str:D $array1, Str:D $array2) {
    say single-common-word($array1.split(','), $array2.split(','));
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (<apple banana cherry>, <banana cherry date>), output => 2 ));
    @tests.push(%( input => (<a ab abc>, <a a ab abc>), output => 2 ));
    @tests.push(%( input => (<orange lemon>, <grape melon>), output => 0 ));
    @tests.push(%( input => (<test test demo>, <test demo demo>), output => 0 ));
    @tests.push(%( input => (<Hello world>, <hello world>), output => 1 ));

    @tests.push(%( input => ([], []), output => 0 ));
    @tests.push(%( input => (["a",], ["a",]), output => 1 ));
    plan +@tests;
    for @tests {
        is single-common-word(|.<input>), .<output>, "{.<input>}";
    }
}
