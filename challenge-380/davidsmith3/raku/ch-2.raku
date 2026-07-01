#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 380 Task 2

Submitted by: Mohammad Sajid Anwar

=head2 Reverse Degree

You are given a string.

Write a script to find the reverse degree of the given string.

For each character, multiply its position in the reversed alphabet (‘a’ = 26, ‘b’ = 25, …, ‘z’ = 1) with its position in the string. Sum these products for all characters in the string to get the reverse degree.

=head3 Example 1:

Input: $str = "z"
Output: 1

Reverse alphabet value of "z" is 1.
Position 1: 1 x 1
Sum of product: 1

=head3 Example 2:

Input: $str = "a"
Output: 26

Reverse alphabet value of "a" is 26.
Position 1: 1 x 26
Sum of product: 26

=head3 Example 3:

Input: $str = "bbc"
Output: 147

Reverse alphabet value of "b" is 25 and "c" is 24.
Position 1: 1 x 25
Position 2: 2 x 25
Position 3: 3 x 24
Sum of product: 25 + 50 + 72 => 147

=head3 Example 4:

Input: $str = "racecar"
Output: 560

Reverse alphabet value of "r" is 9, "a" is 26, "c" is 24 and "e" is 24.
Position 1: 1 x 9
Position 2: 2 x 26
Position 3: 3 x 24
Position 4: 4 x 22
Position 5: 5 x 24
Position 6: 6 x 26
Position 7: 7 x 9
Sum of product: 9 + 52 + 72 + 88 + 120 + 156 + 63

=head3 Example 5:

Input: $str = "zyx"
Output: 14

Reverse alphabet value of "z" is 1, "y" is 2 and "x" is 3.
Position 1: 1 x 1
Position 2: 2 x 2
Position 3: 3 x 3
Sum of product: 1 + 4 + 9

=end pod

subset WordChars of Str:D where / ^ <[a..z]>+ $/;

sub to-num(WordChars $s --> Int) {
    $s.trans("a".."z" => (26...1).map({ .Str })).Int;
}

sub reverse-degree(WordChars $str --> Int) {
    $str.comb.kv.map(-> $i, $c { ($i + 1) * to-num($c) }).sum;
}

#| find reverse degree of str
multi MAIN(Str:D $str) {
    say reverse-degree($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "z", output => 1));
    @tests.push(%( input => "a", output => 26));
    @tests.push(%( input => "bbc", output => 147));
    @tests.push(%( input => "racecar", output => 560));
    @tests.push(%( input => "zyx", output => 14));

    my @should-throw;
    @should-throw.push(%( input => "ABC" ));
    @should-throw.push(%( input => "a4" ));
    @should-throw.push(%( input => "" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is reverse-degree(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { reverse-degree(.<input>) }, "dies on { .<input> }";
    }

    my $proc = run($*EXECUTABLE, $?FILE, 'zyx', :out, :err);
    is $proc.out.slurp(:close).trim, '14', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
