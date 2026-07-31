#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 384 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Base N

You are given a number and a base integer.

Write a script to convert the given number in the given base integer.

=head3 Example 1:

Input: $num = 42, $base = 2
Output: 101010

=head3 Example 2:

Input: $num = 15642094, $base = 16
Output: EEADEE

=head3 Example 3:

Input: $num = 493, $base = 8
Output: 755

=head3 Example 4:

Input: $num = 2228519, $base = 36
Output: 1BRJB

Base 36 uses numbers 0-9 and letters A-Z.

=head3 Example 5:

Input: $num = 123456789, $base = 64
Output: 7MyqL

Base 64 (using 0-9, A-Z, a-z, and extra symbols like + and /)

=end pod

my constant DIGITS = flat(0..9, 'A'..'Z', 'a'..'z', '+', '/').List;

sub base-n(Int:D $num where * >= 0, Int:D $base where 0 < * <= 64 --> Str) {
    return "0" if $num == 0;
    return "1" x $num if $base == 1;
    my $n = $num;
    my @result;
    while $n > 0 {
        my $q = $n div $base;
        my $r = $n mod $base;
        @result.unshift(DIGITS[$r]);
        $n = $q;
    }
    return @result.join;
}

#| convert base-10 NUM to base BASE
multi MAIN(Int:D $num, Int:D $base) {
    say base-n($num, $base);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (42, 2), output => '101010' ));
    @tests.push(%( input => (15642094, 16), output => 'EEADEE' ));
    @tests.push(%( input => (493, 8), output => '755' ));
    @tests.push(%( input => (2228519, 36), output => '1BRJB' ));
    @tests.push(%( input => (123456789, 64), output => '7MyqL' ));
    @tests.push(%( input => (3, 1), output => '111' ));
    my @should-throw;
    @should-throw.push(%( input => (1, 0) ));
    @should-throw.push(%( input => (1, -1) ));
    @should-throw.push(%( input => (1, 65) ));        # assuming 64 digits maximum
    @should-throw.push(%( input => (-1, 2) ));        # assuming non-negative numbers only
    @should-throw.push(%( input => ("foo", 2) ));
    @should-throw.push(%( input => (2, "bar") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is base-n(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { base-n(|.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '8', '2', :out, :err);
    is $proc.out.slurp(:close).trim, '1000', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
