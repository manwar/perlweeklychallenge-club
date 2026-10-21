#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 396 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Finishing Order

You are given two array of integers, @order and @friends.

The @order (size n) contains every integer from 1 to n exactly once. The @friends contains ID in sorted in strictly increasing order.

Write a script to return the array containing IDs in finishing order.

=head3 Example 1:

Input: @order = (3, 1, 4, 2, 5)
       @friends = (1, 2, 4)
Output: (1, 4, 2)

ID 1 finished 2nd.
ID 4 finished 3rd.
ID 2 finished 4th.

=head3 Example 2:

Input: @order = (5, 4, 3, 2, 1)
       @friends = (1, 3, 5)
Output: (5, 3, 1)

ID 5 finished 1st.
ID 3 finished 3rd.
ID 1 finished 5th.

=head3 Example 3:

Input: @order = (2, 4, 1, 3)
       @friends = (1, 2, 3, 4)
Output: (2, 4, 1, 3)

ID 2 finished 1st.
ID 4 finished 2nd.
ID 1 finished 3rd.
ID 3 finished 4th.

=head3 Example 4:

Input: @order = (4, 1, 3, 2)
       @friends = (3)
Output: (3)

=head3 Example 5:

Input: @order = (1, 3, 2, 6, 5, 4)
       @friends = (1, 2, 3)
Output: (1, 3, 2)

ID 1 finished 1st.
ID 3 finished 2nd.
ID 2 finished 3rd.

=end pod

sub finishing-order(@order, @friends --> List) {
    die "Unexpected non-integer in {@order}" unless @order.all ~~ Int:D;
    die "Unexpected non-integer in {@friends}" unless @friends.all ~~ Int:D;
    die "Unexpected order {@order} must include all numbers from 1 to n" unless @order (==) 1..@order.elems;
    die "Unexpected friends {@friends} must be strictly increasing" unless strictly-increasing(@friends);
    die "Unexpected friend in {@friends} without order {@order}" unless @friends (<=) @order;

    @order.grep({ $_ (elem) @friends }).List;
}

sub strictly-increasing(@f --> Bool) {
    return True if @f.elems < 2;
    for 0..(@f.elems-2) -> $i {
        return False if @f[$i] >= @f[$i+1];
    }
    True;
}

#| return FRIENDS sorted by ORDER
multi MAIN(:$order!, :$friends!) {
    say finishing-order($order.split(',').map({ .Int }), $friends.split(',').map({ .Int }));
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ((3, 1, 4, 2, 5), (1, 2, 4)), output => (1, 4, 2)));
    @tests.push(%( input => ((5, 4, 3, 2, 1), (1, 3, 5)), output => (5, 3, 1)));
    @tests.push(%( input => ((2, 4, 1, 3), (1, 2, 3, 4)), output => (2, 4, 1, 3)));
    @tests.push(%( input => ((4, 1, 3, 2), (3,)), output => (3,)));
    @tests.push(%( input => ((1, 3, 2, 6, 5, 4), (1, 2, 3)), output => (1, 3, 2)));
    @tests.push(%( input => ((), ()), output => ()));

    my @should-throw;
    @should-throw.push(%( input => (("A", 1), (1,)) ));
    @should-throw.push(%( input => ((2, 1), ("A",)) ));
    @should-throw.push(%( input => ((1, 2), (1, 2, 3)) ));
    @should-throw.push(%( input => ((1, 2, 4), (1, )) ));
    @should-throw.push(%( input => ((1, 2), (2, 1)) ));
    @should-throw.push(%( input => ((1, 2), (1, 1)) ));
    @should-throw.push(%( input => ((1, 2), (-1, )) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply finishing-order(|.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { finishing-order(|.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '--order=1,2', '--friends=1,2', :out, :err);
    is $proc.out.slurp(:close).trim, '(1 2)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
