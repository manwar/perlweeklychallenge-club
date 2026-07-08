#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 381 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Same Row Column

You are given a n x n matrix containing integers from 1 to n.

Write a script to find if every row and every column contains all the integers from 1 to n.

=head3 Example 1:

Input: @matrix = ([1, 2, 3, 4],
                  [2, 3, 4, 1],
                  [3, 4, 1, 2],
                  [4, 1, 2, 3],)
Output: true

=head3 Example 2:

Input: @matrix = ([1])
Output: true

=head3 Example 3:

Input: @matrix = ([1, 2, 5],
                  [5, 1, 2],
                  [2, 5, 1],)
Output: false

Elements are out of range 1..3.

=head3 Example 4:

Input: @matrix = ([1, 2, 3],
                  [1, 2, 3],
                  [1, 2, 3],)
Output: false

=head3 Example 5:

Input: @matrix = ([1, 2, 3],
                  [3, 1, 2],
                  [3, 2, 1],)
Output: false

=end pod

sub same-row-column(@matrix --> Bool) {
    my $n = @matrix.elems;
    die "input is not a square matrix" if @matrix.map({ .elems != $n }).any;
    die "input contains invalid input" if @matrix.map({ .map({ $_ !~~ Int  }) }).flat.any;
    my $target = (1..$n).Set;
    for ^$n -> $i {
        return False if @matrix[$i] !(==) $target;
        return False if @matrix.map({ $_[$i] }) !(==) $target;
    }
    True;
}

#| determine if two-dimensional matrix has the same row column property
multi MAIN(Str:D $matrix) {
    say same-row-column($matrix.split(";").map({ .split(",").map({ .Int }).Array }).Array);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ([1, 2, 3, 4],
                             [2, 3, 4, 1],
                             [3, 4, 1, 2],
                             [4, 1, 2, 3]), output => True ));
    @tests.push(%( input => ([1]), output => True ));
    @tests.push(%( input => ([1, 2, 3],
                             [5, 1, 2],
                             [2, 5, 1]), output => False ));
    @tests.push(%( input => ([1, 2, 3],
                             [1, 2, 3],
                             [1, 2, 3]), output => False ));
    @tests.push(%( input => ([1, 2, 3],
                             [3, 1, 2],
                             [3, 2, 1]), output => False ));
    @tests.push(%( input => ([1, 2],
                             [2, 1]), output => True ));
    my @should-throw;
    @should-throw.push(%( input => ([1, 2, 2],
                                    [2, 1])));
    @should-throw.push(%( input => (["a"])));

    plan @tests + @should-throw + 3;
    for @tests {
        is same-row-column(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { same-row-column(.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1, 2; 2, 1', :out, :err);
    is $proc.out.slurp(:close).trim, 'True', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
