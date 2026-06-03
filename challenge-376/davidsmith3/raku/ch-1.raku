#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 376 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Chessboard Squares

You are given two coordinates of a square on 8x8 chessboard.

Write a script to find the given two coordinates have the same colour.

8 W B W B W B W B
7 B W B W B W B W
6 W B W B W B W B
5 B W B W B W B W
4 W B W B W B W B
3 B W B W B W B W
2 W B W B W B W B
1 B W B W B W B W
  a b c d e f g h

=head3 Example 1:

Input: $c1 = "a7", $c2 = "f4"
Output: true

=head3 Example 2:

Input: $c1 = "c1", $c2 = "e8"
Output: false

=head3 Example 3:

Input: $c1 = "b5", $c2 = "h2"
Output: false

=head3 Example 4:

Input: $c1 = "f3", $c2 = "h1"
Output: true

=head3 Example 5:

Input: $c1 = "a1", $c2 = "g8"
Output: false

=end pod

subset Coordinate of Str where / ^ <[a..hA..H]><[1..8]> $ /;

my %COL-NUMS = 'a'..'h' Z=> 1..8;

multi chessboard-squares(Coordinate $c1, Coordinate $c2 --> Bool) {
   (%COL-NUMS{$c1.lc.substr(0, 1)} +
    $c1.lc.substr(1, 1) +
    %COL-NUMS{$c2.lc.substr(0, 1)} +
    $c2.lc.substr(1, 1)) %% 2;
}

multi chessboard-squares(Str:D $c1, Str:D $c2) {
    die "Unexpected input received $c1, $c2";
}

#| Determine if chess coordinates c1 and c2 are the same color
multi MAIN(Str:D $c1, Str:D $c2) {
    say chessboard-squares($c1, $c2);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%(input => <a7 f4>, output => True));
    @tests.push(%(input => <c1 e8>, output => False));
    @tests.push(%(input => <b5 h2>, output => False));
    @tests.push(%(input => <f3 h1>, output => True));
    @tests.push(%(input => <a1 g8>, output => False));

    @tests.push(%(input => <A1 G8>, output => False));
    @tests.push(%(input => <A1 A1>, output => True));
    @tests.push(%(input => <A1 C1>, output => True));
    my @should-throw;
    @should-throw.push(%( input => ["a1", ""] ));
    @should-throw.push(%( input => ["", "a1"] ));
    @should-throw.push(%( input => ["z1", "a1"] ));
    @should-throw.push(%( input => ["a10", "a1"] ));
    @should-throw.push(%( input => ["foo", "a1"] ));

    plan @tests + @should-throw + 3;
    for @tests {
        is chessboard-squares(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { chessboard-squares(|.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, "a1", "g8", :out, :err);
    is $proc.out.slurp(:close).trim, 'False', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
