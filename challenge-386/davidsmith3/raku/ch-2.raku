#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 386 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Rational Numbers

You are given two strings representing non-negative rational numbers.

Write a script to return true if the two given rational numbers are same otherwise false.

=head3 Example 1:
Input: $rat1 = "0.(12)"
       $rat2 = "0.(121)"
Output: false

Expansion of "0.(12)"  = 0.12 12 12 12
Expansion of "0.(121)" = 0.121 121 121

=head3 Example 2:
Input: $rat1 = "0.1(23)"
       $rat2 = "0.12(32)"
Output: true

Expansion of "0.1(23)"  = 0.1 23 23 23
Expansion of "0.12(32)" = 0.12 32 32 32

=head3 Example 3:
Input: $rat1 = "0.1(234)"
       $rat2 = "0.12(342)"
Output: true

Expansion of "0.1(234)"  = 0.1 234 234 234
Expansion of "0.12(342)" = 0.12 342 342 342

=head3 Example 4:
Input: $rat1 = "12.99(99)"
       $rat2 = "13."
Output: true

=head3 Example 5:
Input: $rat1 = "0.(123)"
       $rat2 = "0.1(231)"
Output: true

=end pod

multi rat(Str:D $r where /^ \d+ $/ --> Rat) {
    $r.Rat;
}

multi rat(Str:D $r where /^ \d+ \. \d* $/ --> Rat) {
    my $num = $r ~ '0';  # handle form n. given in example 4
    $num.Rat;
}

multi rat(Str:D $r --> Rat) {
    # https://en.wikipedia.org/wiki/Repeating_decimal#Converting_repeating_decimals_to_fractions
    my $match = $r ~~ /^ $<whole>=[\d+] \. $<pre>=[\d*] \($<repetend>=[\d+]\) $/;
    die "Unexpected input $r" unless $match;
    my $numerator = ($<whole> ~ $<pre> ~ $<repetend>).Int - ($<whole> ~ $<pre>).Int;
    my $denominator = ('9' x $<repetend>.chars ~ '0' x $<pre>.chars).Int;
    $numerator / $denominator;
}

sub rational-numbers(Str:D $rat1, Str:D $rat2 --> Bool) {
    rat($rat1) == rat($rat2);
}

#| determine if non-negative rational numbers rat1 and rat2 are the same
multi MAIN(Str:D $rat1, Str:D $rat2) {
    say rational-numbers($rat1, $rat2);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("0.(12)", "0.(121)"), output => False ));
    @tests.push(%( input => ("0.1(23)", "0.12(32)"), output => True ));
    @tests.push(%( input => ("0.1(234)", "0.12(342)"), output => True ));
    @tests.push(%( input => ("12.99(99)", "13."), output => True ));
    @tests.push(%( input => ("0.(123)", "0.1(231)"), output => True ));
    @tests.push(%( input => ("2.0", "2.0"), output => True ));
    @tests.push(%( input => ("2.", "2."), output => True ));
    @tests.push(%( input => ("2", "2"), output => True ));
    @tests.push(%( input => ("999.9(9)", "1000"), output => True ));

    my @should-throw;
    @should-throw.push(%( input => (12, "") ));
    @should-throw.push(%( input => (12, "abc") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is rational-numbers(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { rational-numbers(|.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '2.', '2.', :out, :err);
    is $proc.out.slurp(:close).trim, 'True', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
