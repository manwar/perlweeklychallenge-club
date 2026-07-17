#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 382 Task 1

Submitted by: Peter Campbell Smith
=head2 Hamiltonian Cycle

You are given a target number.

Write a script to arrange all the whole numbers from 1 up to the given target number into a circle so that every pair of side-by-side numbers adds up to a perfect square. Please make sure, the last number and the first must also add up to a square.

=head3 Example 1:

Input: $n = 32
Output: 1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15

1  + 8  = 9
8  + 28 = 36
28 + 21 = 49
21 + 4  = 25
4  + 32 = 36
32 + 17 = 49
17 + 19 = 36
19 + 30 = 49

so on, all the way through the sequence.

=head3 Example 2:

Input: $n = 15
Output: ()

No valid circular list of numbers exists.

=head3 Example 3:

Input: $n = 34
Output: 1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2, 14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3

=end pod

sub is-square(Int:D $n --> Bool) {
    sqrt($n) == sqrt($n).Int;
}

sub build-graph(Int:D $n --> Map) {
    # adjacency list representation from CLRS 22.1
    my %g;
    for 1..$n -> $i {
        for 1..$n -> $j {
            next if $i == $j; # avoid edges to self
            my $sum = $i + $j;
            if is-square($sum) {
                %g{$i}.push($j) unless $j (elem) %g{$i};
                %g{$j}.push($i) unless $i (elem) %g{$j};
            }
        }
    }
    for 2..$n -> $i {
        # use 0 as the destination vertex from any other vertex if that vertex plus 1 is square
        %g{$i}.push(0) if is-square($i.succ);
    }
    %g;
}

sub hamiltonian-cycle(Int:D $n where * > 1 --> List) {
    my %g = build-graph($n);
    # depth first search from CLRS 22.3
    return () if %g.elems != $n; # no vertex without a path out
    my @all-paths;
    my @path;
    my %color = 0..$n Z=> "WHITE" xx $n + 1;

    sub dfs-visit(Int:D $u) {
        @path.push($u);
        %color{$u} = "GRAY";
        if $u == 0 {
            my @complete = @path;
            @complete.pop;  # we want _all_ paths since the one we find first might not be the one in the challenge
            @all-paths.push(@complete);
        } else {
            for @(%g{$u}) -> $v {
                dfs-visit($v) if %color{$v} eq "WHITE";
            }
        }
        %color{$u} = "WHITE";
        @path.pop();
    }
    dfs-visit(1);
    @all-paths.grep({ $_.unique.elems == $n }).List; # remove non-hamiltonian paths
}

#| Find the hamiltonian cycle if exists for the graph of numbers 1 to n when there is an edge from i to j if i + j is a perfect square
multi MAIN(Int:D $n, Bool:D :$verbose=False) {
    if $verbose {
        my @cycles = hamiltonian-cycle($n);
        for @cycles -> $c {
            $c.push(1);
            say $c;
            for $c.rotor(2 => -1) -> @p {
                say sprintf("%2s", @p[0]) ~ " + " ~ sprintf("%2s", @p[1]) ~ " = " ~ sprintf("%2s", @p[0] + @p[1]);
            }
        }
    } else {
        say hamiltonian-cycle($n);
    }
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => 32,
                   output => (1, 8, 28, 21, 4, 32, 17, 19, 30, 6, 3, 13, 12, 24, 25, 11, 5, 31, 18, 7, 29, 20, 16, 9, 27, 22, 14, 2, 23, 26, 10, 15) ));
    @tests.push(%( input => 15,
                   output => () ));
    @tests.push(%( input => 34,
                   output => (1, 8, 28, 21, 4, 32, 17, 19, 6, 30, 34, 15, 10, 26, 23, 2, 14, 22, 27, 9, 16, 33, 31, 18, 7, 29, 20, 5, 11, 25, 24, 12, 13, 3) ));
    @tests.push(%( input => 2,
                   output => () ));
    my @should-throw;
    @should-throw.push(%( input => "" ));
    @should-throw.push(%( input => "abc" ));
    @should-throw.push(%( input => 0 ));
    @should-throw.push(%( input => 1 ));

    plan @tests + @should-throw + 3;
    for @tests {
        my @result = hamiltonian-cycle(.<input>);
        ok (.<output>.elems == 0 && @result.elems == 0) || (.<output>.join(",") (elem) @result.map({ .join(",") })), "{ .<input> }";
    }
    for @should-throw {
        dies-ok { hamiltonian-cycle(.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 15, :out, :err);
    is $proc.out.slurp(:close).trim, '()', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
