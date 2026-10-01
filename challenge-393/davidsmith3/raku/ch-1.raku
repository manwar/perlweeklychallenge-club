#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 393 Task 1

Submitted by: Ulrich Rieke
=head2 Pythagoras Multiplied

You are given a positive integer n.

Find the number of all positive integer triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are integers <= n.

=head3 Example 1:

Input: $n = 20
Output: 12

(3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
(8,6,10), (8,15,17), (9,12,15),(12,5,13),
(12,9,15),(12,16,20),(15,8,17),(16,12,20)

=head3 Example 2:

Input: $n = 7
Output: 2

(3,4,5),(4,3,5)

=head3 Example 3:

Input: $n = 1
Output: 0

=head3 Example 4:

Input: $n = 15
Output: 8

=head3 Example 5:

Input: $n = 30
Output: 22

=end pod

multi pythagoras-multiplied(Int:D $n where * > 0 --> Int) {
    return 0 if $n < 2;
    my $possible-c-squared = (1..$n).map(* ** 2).Set;
    (1..$n X 1..$n).map(-> ($a, $b) { $a ** 2 + $b ** 2 })
                   .grep(-> $c { $c (elem) $possible-c-squared })
                   .elems;
}

multi pythagoras-multiplied(Int:D $n) {
    die "Unexpected non-positive input $n";
}

#| Output number of pythagorean triplets where all elems are less than or equal to N
multi MAIN(Int:D $n) {
    say pythagoras-multiplied($n);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => 20, output => 12));
    @tests.push(%( input => 7, output => 2));
    @tests.push(%( input => 1, output => 0));
    @tests.push(%( input => 15, output => 8));
    @tests.push(%( input => 30, output => 22));

    my @should-throw;
    @should-throw.push(%( input => 0 ));
    @should-throw.push(%( input => -1 ));

    plan @tests + @should-throw + 3;
    for @tests {
        is pythagoras-multiplied(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { pythagoras-multiplied(.<input>) }, Exception, "dies on { .<input> }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '7', :out, :err);
    is $proc.out.slurp(:close).trim, '2', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
