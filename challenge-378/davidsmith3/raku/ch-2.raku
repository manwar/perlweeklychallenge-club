#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 378 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Sum of Words

You are given three strings consisting of lower case English letters ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.

Write a script to find if sum of first two strings return the third string.

=head3 Example 1:
Input: $str1 = "acb", $str2 = "cba", $str3 = "cdb"
Output: true

$str1 = "acb" = 021
$str2 = "cba" = 210
$str3 = "cdb" = 231
$str1 + $str2 = $str3

=head3 Example 2:
Input: $str1 = "aab", $str2 = "aac", $str3 = "ad"
Output: true

$str1 = "aab" = 001
$str2 = "aac" = 002
$str3 = "ad"  = 03

=head3 Example 3:
Input: $str1 = "bc", $str2 = "je", $str3 = "jg"
Output: false

$str1 = "bc" = 12
$str2 = "je" = 94
$str3 = "jg" = 96

=head3 Example 4:
Input: $str1 = "a", $str2 = "aaaa", $str3 = "aa"
Output: true

$str1 = "a"    = 0
$str2 = "aaaa" = 0000
$str3 = "aa"   = 00

=head3 Example 5:
Input: $str1 = "c", $str2 = "d", $str3 = "h"
Output: false

$str1 = "c" = 2
$str2 = "d" = 3
$str3 = "h" = 7

=head3 Example 6:
Input: $str1 = "gfi", $str2 = "hbf", $str3 = "bdhd"
Output: true

$str1 =  "gfi" =  658
$str2 =  "hbf" =  715
$str3 = "bdhd" = 1373

=end pod

subset WordChars of Str:D where / ^ <[a..j]>+ $/;

sub to-num(WordChars $s --> Int) {
    $s.trans("a".."j" => "0".."9").Int;
}

sub sum-words(WordChars $str1, WordChars $str2, WordChars $str3 --> Bool) {
    to-num($str1) + to-num($str2) == to-num($str3);
}

#| determine if $str1 + $str2 = $str3
multi MAIN(Str:D $str1, Str:D $str2, Str:D $str3) {
    say sum-words($str1, $str2, $str3);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("acb", "cba", "cdb"), output => True));
    @tests.push(%( input => ("aab", "aac", "ad"), output => True));
    @tests.push(%( input => ("bc", "je", "jg"), output => False));
    @tests.push(%( input => ("a", "aaaa", "aa"), output => True));
    @tests.push(%( input => ("c", "d", "h"), output => False));
    @tests.push(%( input => ("gfi", "hbf", "bdhd"), output => True));

    my @should-throw;
    @should-throw.push(%( input => ("abc", "abc", "ABC") ));
    @should-throw.push(%( input => ("klm", "abc", "abc") ));
    @should-throw.push(%( input => ("abc", "123", "abc") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is sum-words(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { sum-words(|.<input>) }, "dies on { .<input> }";
    }

    my $proc = run($*EXECUTABLE, $?FILE, 'gfi', 'hbf', 'bdhd', :out, :err);
    is $proc.out.slurp(:close).trim, 'True', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
