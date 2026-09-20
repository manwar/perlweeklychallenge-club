#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 391 Task 2

Submitted by: Mohammad Sajid Anwar
=head2 Arrange Box

You are given an array of box dimensions.

Write a script to determine the maximum number of these boxes that can fit inside each other in a single stack. For a box to fit inside another, it must be smaller in both dimensions.

=head3 Example 1:

Input: @boxes = ([1, 3], [3, 5], [6, 8], [2, 4])
Output: 4

Sort by width ascending: ([1, 3], [2, 4], [3, 5], [6, 8])
Extract heights: [3, 4, 5, 8]
[1, 3] -> [2, 4] -> [3, 5] -> [6, 8]

=head3 Example 2:

Input: @boxes = ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3])
Output: 3

Sort by width ascending: ([2, 3], [4, 6], [4, 5], [4, 3], [6, 7])
Extract heights: (3, 6, 5, 3, 7)
[2, 3] -> [4, 5] -> [6, 7]

=head3 Example 3:

Input: @boxes = ([5, 5], [5, 5], [5, 5])
Output: 1

Sort by width ascending: ([5, 5], [5, 5], [5, 5])
Extract heights: (5, 5, 5)
[5, 5]

=head3 Example 4:

Input: @boxes = ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400])
Output: 4

Sort by width ascending: ([2, 100], [3, 200], [4, 300], [5, 400], [5, 50])
Extract heights: (100, 200, 300, 400, 50)
[2, 100] -> [3, 200] -> [4, 300] -> [5, 400]

=head3 Example 5:

Input: @boxes = ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25])
Output: 3

Sort by width ascending: ([10, 20], [12, 18], [15, 10], [16, 25], [20, 30])
Extract heights: (20, 18, 10, 25, 30)
[15, 10] -> [16, 25] -> [20, 30]

=end pod

sub all-fit(@c --> Bool) {
    my @widths = @c.map({ .head });
    return False if @widths.unique.elems != @widths.elems;
    my @lengths = @c.sort.map({ .tail });
    so all(@lengths.rotor(2 => -1).map({ .head < .tail }));
}

sub valid(@boxes --> Bool) {
    return False unless @boxes.elems > 0;
    for @boxes {
        return False unless .elems == 2;
        return False unless .all ~~ Int;
        return False unless .all > 0;
    }
    True;
}

sub arrange-boxes(@boxes --> Int) {
    die "Unexpected input { @boxes }" unless valid(@boxes);
    return 1 if @boxes.elems == 1;
    for @boxes.elems...2 -> $n {
        for @boxes.combinations($n) -> @candidate {
            return $n if all-fit(@candidate);
        }
    }
    1;
}

#| return maximum number of BOXes that fit inside each other
multi MAIN(:@box) {
    say arrange-boxes(@box.map({ .split(',').map({ .Int }).List }).List);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ([1, 3], [3, 5], [6, 8], [2, 4]), output => 4));
    @tests.push(%( input => ([4, 5], [4, 6], [6, 7], [2, 3], [4, 3]), output => 3));
    @tests.push(%( input => ([5, 5], [5, 5], [5, 5]), output => 1));
    @tests.push(%( input => ([2, 100], [3, 200], [4, 300], [5, 50], [5, 400]), output => 4));
    @tests.push(%( input => ([10, 20], [15, 10], [20, 30], [12, 18], [16, 25]), output => 3));
    @tests.push(%( input => ([1, 1], ), output => 1));
    @tests.push(%( input => ([1, 1], [1, 1]), output => 1));
    @tests.push(%( input => ([2, 1], [1, 1]), output => 1));
    @tests.push(%( input => ([1, 1], [2, 2]), output => 2));
    @tests.push(%( input => ([1, 5], [2, 3], [3, 3]), output => 1));
    @tests.push(%( input => ([1, 5], [2, 2], [3, 3]), output => 2));
    @tests.push(%( input => ([1, 1], [2, 3], [3, 3]), output => 2));
    @tests.push(%( input => ([1, 1], [2, 4], [3, 3]), output => 2));

    my @should-throw;
    @should-throw.push(%( input => ([1, 2], ["a", 3]) ));
    @should-throw.push(%( input => ([1, 2, 3], ) ));
    @should-throw.push(%( input => ([1, ], ) ));

    plan @tests + @should-throw + 3;
    for @tests {
        is arrange-boxes(.<input>), .<output>, "{ .<input>.raku }";
    }
    for @should-throw {
        throws-like { arrange-boxes(.<input>) }, Exception, "dies on { .<input>.raku }", message => /Unexpected/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '--box=1,1', '--box=2,2', :out, :err);
    is $proc.out.slurp(:close).trim, '2', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
