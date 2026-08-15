#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 386 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Reverse Base

You are given a string representing a number, and an integer specifying the base of that representation.

Write a function to convert this string to an integer. (For bases greater than 10, use characters A-Z, a-z, + and / in that order.)

=head3 Example 1:

Input: $num = "101010", $base = 2
Output: 42

=head3 Example 2:

Input: $num = "EEADEE", $base = 16
Output: 15642094

=head3 Example 3:

Input: $num = "755", $base = 8
Output: 493

=head3 Example 4:

Input: $num = "1BRJB", $base = 36
Output: 2228519

=head3 Example 5:

Input: $num = "7MyqL", $base = 64
Output: 123456789

=end pod

my constant @CHARS = flat('0'..'9', 'A'..'Z', 'a'..'z', '+', '/');
my constant %DIGITS = @CHARS.antipairs;

sub reverse-base(Int:D $base where 1 < * <= +@CHARS,
                 Str:D $num where { .chars > 0 && .comb (<=) @CHARS[^$base] } --> Int) {
    $num.flip.comb.kv.map(-> $i, $c { %DIGITS{$c} * ($base ** $i) }).sum;
}

#| convert string representation NUM with base BASE to base 10
multi MAIN(Str:D $num, Int:D $base) {
    say reverse-base($base, $num);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("101010", 2), output => 42 ));
    @tests.push(%( input => ("EEADEE", 16), output => 15642094 ));
    @tests.push(%( input => ("755", 8), output => 493 ));
    @tests.push(%( input => ("1BRJB", 36), output => 2228519 ));
    @tests.push(%( input => ("7MyqL", 64), output => 123456789 ));
    @tests.push(%( input => ("0", 2), output => 0 ));
    @tests.push(%( input => ("0", 16), output => 0 ));
    @tests.push(%( input => ("1", 2), output => 1 ));
    @tests.push(%( input => ("9", 10), output => 9 ));
    @tests.push(%( input => ("F", 16), output => 15 ));
    @tests.push(%( input => ("/", 64), output => 63 ));
    my @should-throw;
    @should-throw.push(%( input => ("", 2) ));
    @should-throw.push(%( input => ("A!", 16) ));
    @should-throw.push(%( input => ("10", 0) ));
    @should-throw.push(%( input => ("10", -1) ));
    @should-throw.push(%( input => ("10", 65) ));
    @should-throw.push(%( input => ("2", 2) ));
    @should-throw.push(%( input => ("A", 10) ));
    @should-throw.push(%( input => ("G", 16) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is reverse-base(|.<input>.reverse), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { reverse-base(|.<input>.reverse) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'A', '16', :out, :err);
    is $proc.out.slurp(:close).trim, '10', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
