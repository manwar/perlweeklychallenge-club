#!/bin/env raku

#`[
    Perl weekly chanllege 114, Task #1 Next Palindrome Number

    You are given a positive integer $N.
    Write a script to find out the next Palindrome Number higher than the given integer $N.

    Example

    Input: $N = 1234
    Output: 1331

    Input: $N = 999
    Output: 1001
#]

my method is-palindrome(UInt:D $n: --> Bool:D) { $n.flip eq $n }

sub MAIN(UInt:D $N) {
    put ($N^..*).grep(*.&is-palindrome)[0];
}
