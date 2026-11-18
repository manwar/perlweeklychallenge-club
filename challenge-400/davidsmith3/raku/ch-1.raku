#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 400 Task 1

Submitted by: Ali Moradi
=head2 Largest Interval

You are given a positive integer.

Write a script that generates a sequence of integers from 1 to given positive integer,
filtering out any numbers that contain repeating digits (e.g., 11, 99, 100, and 101 are
excluded) and return the biggest jump.

=head3 Example 1:

Input: $int = 20
Output: 2

Biggest jump between 10 and 12.

=head3 Example 2:

Input: $int = 110
Output: 4

Biggest jump between 98 and 102.

=head3 Example 3:

Input: $int = 500
Output: 11

Biggest jump between:
a) 109 and 120 => 11
b) 219 and 230 => 11
c) 329 and 340 => 11
d) 439 and 450 => 11

=head3 Example 4:

Input: $int = 2026
Output: 105

Biggest jump between 1098 and 1203.

=head3 Example 5:

Input: $int = 10000
Output: 105

The largest gap is 105, between 1098 and 1203. And again between 8796 and 8901.

=end pod

subset PosInt of Int where * > 0;

multi largest-interval(PosInt $int --> Int) {
    return 0 if $int == 1;
    (1..$int).grep(&has-no-repeating).rotor(2 => -1).map({ .tail - .head }).max;
}

multi largest-interval($int) {
    die "Unexpected input $int - must be positive integer"
}

sub has-no-repeating(PosInt $int --> Bool) {
    my @digits = $int.Str.comb;
    return @digits.unique.elems == @digits.elems;
}

#| Find largest gap from 1 to INT between two numbers after removing numbers with
#| repeating digits
multi MAIN(Int:D $int) {
    say largest-interval($int);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => 20, output => 2));
    @tests.push(%( input => 110, output => 4));
    @tests.push(%( input => 500, output => 11));
    @tests.push(%( input => 2026, output => 105));
    @tests.push(%( input => 10000, output => 105));
    @tests.push(%( input => 1, output => 0));
    @tests.push(%( input => 2, output => 1));
    @tests.push(%( input => 11, output => 1));
    @tests.push(%( input => 12, output => 2));         # include input in range

    my @should-throw;
    @should-throw.push(%( input => 0));
    @should-throw.push(%( input => -1));
    @should-throw.push(%( input => 5.5));

    plan @tests + @should-throw + 3;
    for @tests {
        is largest-interval(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { largest-interval(.<input>) },
                      Exception, "dies on { .<input> }",
                      message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '20', :out, :err);
    is $proc.out.slurp(:close).trim, '2', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
