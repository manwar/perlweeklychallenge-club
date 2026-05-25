#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 375 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Find K-Beauty

You are given a number and a digit (k).

Write a script to find the K-Beauty of the given number. The K-Beauty of an integer number is defined as the number of substrings of given number when it is read as a string has length of ‘k’ and is a divisor of given number.

=head3 Example 1:

Input: $num = 240, $k = 2
Output: 2

Substring with length 2:
24: 240 is divisible by 24
40: 240 is divisible by 40

=head3 Example 2:

Input: $num = 1020, $k = 2
Output: 3

Substring with length 2:
10: 1020 is divisible by 10
02: 1020 is divisible by 2
20: 1020 is divisible by 20

=head3 Example 3:

Input: $num = 444, $k = 2
Output: 0

Substring with length 2:
First "44": 444 is not divisible by 44
Second "44": 444 is not divisible by 44

=head3 Example 4:

Input: $num = 17, $k = 2
Output: 1

Substring with length 2:
17: 17 is divisible by 17

=head3 Example 5:

Input: $num = 123, $k = 1
Output: 2

Substring with length 1:
1: 123 is divisible by 1
2: 123 is not divisible by 2
3: 123 is divisible by 3

=end pod

subset NonNegativeInt of Int where * >= 0;

multi find-k-beauty(NonNegativeInt $num, NonNegativeInt $k --> Int) {
    my $num-text = ~$num;
    my $count = 0;
    for 0..($num-text.chars-$k) -> $start {
        my $candidate = $num-text.substr($start, $k).Int;
        next if $candidate == 0;
        $count++ if $num %% $candidate;
    }
    $count;
}

multi find-k-beauty($num, $k) {
    die "Unexpected input $num, $k";
}

#| find k-beauty of num and k
multi MAIN(Int:D $num, Int:D $k) {
    say find-k-beauty($num, $k);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (240, 2), output => 2 ));
    @tests.push(%( input => (1020, 2), output => 3 ));
    @tests.push(%( input => (444, 2), output => 0 ));
    @tests.push(%( input => (17, 2), output => 1 ));
    @tests.push(%( input => (123, 1), output => 2 ));

    @tests.push(%( input => (1, 0), output => 0 ));
    @tests.push(%( input => (0, 1), output => 0 ));
    @tests.push(%( input => (10, 1), output => 1 ));
    @tests.push(%( input => (123, 4), output => 0 ));
    @tests.push(%( input => (1212, 2), output => 2 ));
    my @should-throw;
    @should-throw.push(%( input => (1, -1) ));
    @should-throw.push(%( input => (-1, 0) ));
    @should-throw.push(%( input => ("a", 1) ));
    @should-throw.push(%( input => (1, "a") ));
    @should-throw.push(%( input => ("a", "a") ));

    plan @tests + @should-throw;
    for @tests {
        is find-k-beauty(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { find-k-beauty(|.<input>) }, "dies on { .<input> }";
    }
}
