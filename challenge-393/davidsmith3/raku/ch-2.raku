#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 393 Task 2

Submitted by: Ulrich Rieke
=head2 Prime Step

You are given a string with English alphabetic characters only.

What is the absolute difference of the sum of the ASCII values of the characters in the string to the nearest prime number?

=head3 Example 1:

Input: $str = "hello"
Output: 9

The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
The nearest prime number to 532 is 523, resulting in an absolute difference of 9.

=head3 Example 2:

Input: $str = "football"
Output: 2

Starting with the values [102,111,111,116,98,97,108,108] and the sum 851.
We find 853 as the nearest prime number, so the difference is 2.


=head3 Example 3:

Input: $str = "a"
Output: 0

=head3 Example 4:

Input: $str = "challenge"
Output: 2

The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103, 101], which sum up to 931.
The nearest prime number to 931 is 929, so the difference is 2.

=head3 Example 5:

Input: $str = "perl"
Output: 2

The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
Nearest prime is 433, so the difference is 2.

=end pod

sub closest-prime-distance(Int:D $n --> Int) {
    my $i = 0;
    loop {
        last if ($n + $i).is-prime or ($n - $i).is-prime;  # will reach 2 or 3
        $i++;
    }
    return $i;
}

multi prime-step(Str:D $str where / ^ <[a..zA..Z]>+ $ / --> Int) {
    closest-prime-distance($str.ords.sum);
}

multi prime-step(Str:D $str) {
    die "Unexpected input {$str}.  Must have at least one character and all characters must be alphabetic."
}

#| Output the absolute difference of the sum of the ASCII values of the characters in STR to the nearest prime number
multi MAIN(Str:D $str) {
    say prime-step($str);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => "hello", output => 9));
    @tests.push(%( input => "football", output => 2));
    @tests.push(%( input => "a", output => 0));
    @tests.push(%( input => "challenge", output => 2));
    @tests.push(%( input => "perl", output => 2));
    @tests.push(%( input => "RaKu", output => 2));

    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "foo!" ));
    @should-throw.push(%( input => "bar2" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is prime-step(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { prime-step(.<input>) }, Exception, "dies on { .<input> }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'football', :out, :err);
    is $proc.out.slurp(:close).trim, '2', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
