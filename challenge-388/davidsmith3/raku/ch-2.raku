#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 388 Task 2

Submitted by: Roger Bell_West
=head2 Secret Santa

A company with $n employees is running a Secret Santa exchange. Each employee buys one gift and receives one gift.

Write a script to return the total number of valid gift assignments where no employee receives the gift they originally bought (i.e., employee $i must not be assigned gift $i).

=head3 Example 1:

Input: $n = 1
Output: 0

Only 1 participant exists. They would have to receive their own gift, which is invalid.

=head3 Example 2:

Input: $n = 2
Output: 1

Participants 1 and 2 must swap gifts ([2, 1]).

=head3 Example 3:

Input: $n = 3
Output: 2

The 2 valid gift arrays where array[i] is who person i+1 receives from:
[2, 3, 1]
[3, 1, 2]

=head3 Example 4:

Input: $n = 4
Output: 9

The 9 valid arrays are:
[2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
[3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
[4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],

=head3 Example 5:

Input: $n = 5
Output: 44

There are 44 valid permutations out of 5! = 120 total possible arrangements.

=end pod

multi secret-santa(Int:D $n where * > 0 --> Int) {
    return 0 if $n == 1;
    return 1 if $n == 2;
    my $result = 1;
    for 3..$n -> $i {
        $result *= $i;
        $i %% 2 ?? $result++ !! $result--;
    }
    $result;
}

multi secret-santa($n) {
    die "Employee count must be a positive integer.  Received $n";
}

#| return the number of gift assignments for a secret Santa program for N employees
multi MAIN(Int:D $n) {
    say secret-santa($n);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => 1, output => 0));
    @tests.push(%( input => 2, output => 1));
    @tests.push(%( input => 3, output => 2));
    @tests.push(%( input => 4, output => 9));
    @tests.push(%( input => 5, output => 44));
    @tests.push(%( input => 6, output => 265));
    @tests.push(%( input => 7, output => 1854));
    @tests.push(%( input => 8, output => 14833));
    @tests.push(%( input => 25, output => 5706255282633466762357224));

    my @should-throw;
    @should-throw.push(%( input => -1 ));
    @should-throw.push(%( input => 0 ));
    @should-throw.push(%( input => "foo" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is secret-santa(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { secret-santa(.<input>) }, Exception, "dies on { .<input> }", message => /'Employee count'/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '2', :out, :err);
    is $proc.out.slurp(:close).trim, '1', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
