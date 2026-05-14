#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 373 Task 2
Submitted by: Mark Anderson
=CHALLENGE
You are given a list and a non-negative integer.

Write a script to divide the given list into given non-negative integer equal parts. Return -1 if the integer is more than the size of the list.

=head3 Example 1:
Input: @list = (1,2,3,4,5), $n = 2
Output: ((1,2,3), (4,5))

5 / 2 = 2 remainder 1.
The extra element goes into the first chunk.

=head3 Example 2:
Input: @list = (1,2,3,4,5,6), $n = 3
Output: ((1,2), (3,4), (5,6))

6 / 3 = 2 remainder 0.

=head3 Example 3:
Input: @list = (1,2,3), $n = 2
Output: ((1,2), (3))

=head3 Example 4:
Input: @list = (1,2,3,4,5,6,7,8,9,10), $n = 5
Output: ((1,2), (3,4), (5,6), (7,8), (9,10))

=head3 Example 5:
Input: @list = (1,2,3), $n = 4
Output: -1

=head3 Example 6:
Input: @list = (72,57,89,55,36,84,10,95,99,35), $n = 7;
Output: ((72,57), (89,55), (36,84), (10), (95), (99), (35))

=end pod

subset ListOrInt where List | Int;
subset PosInt of Int where * > 0; # don't know how to handle n=0

sub my-sub(@list, PosInt $n --> ListOrInt) {
    return -1 if $n > @list;
    my $chunk = @list div $n;
    my $extra = @list mod $n;
    my $split = $extra * ($chunk + 1);
    my @head = @list[0..^$split];
    my @tail = @list[$split..*];
    (|@head.rotor($chunk + 1), |@tail.rotor($chunk));
}

#| perform List Division on comma separated list into n parts
multi MAIN(Str:D $list, Int:D $n) {
    say my-sub($list.split(","), $n);
}

multi to-string(@list) {
    @list.map({ .join(",") }).join("|");
}

multi to-string($num) {
    ~$num;
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%{ input => ((1,2,3,4,5), 2), output => ((1,2,3), (4,5)) });
    @tests.push(%{ input => ((1,2,3,4,5,6), 3), output => ((1,2), (3,4), (5,6)) });
    @tests.push(%{ input => ((1,2,3), 2), output => ((1,2), (3,)) });
    @tests.push(%{ input => ((1,2,3,4,5,6,7,8,9,10), 5), output => ((1,2), (3,4), (5,6), (7,8), (9,10)) });
    @tests.push(%{ input => ((1,2,3), 4), output => -1 });
    @tests.push(%{ input => ((72,57,89,55,36,84,10,95,99,35), 7), output => ((72,57), (89,55), (36,84), (10,), (95,), (99,), (35,)) });
    @tests.push(%{ input => ((1,), 1), output => ((1,),) });
    @tests.push(%{ input => ((1, 2), 1), output => ((1,2),) });
    @tests.push(%{ input => ((1, 2), 2), output => ((1,), (2,)) });
    plan +@tests;
    for @tests {
        is to-string(my-sub(|.<input>)), to-string(.<output>), "{ .<input>.raku }";
    }
}
