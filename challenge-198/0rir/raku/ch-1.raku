#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
# use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
198-1: Max Gap              Submitted by: Mohammad S Anwar
You are given a list of integers, @list, the total pairs in the sorted list
where 2 consecutive elements has the max gap. If the list contains less than
2 elements then return 0.

Example 1
Input:  @list = (2,5,8,1)
Output: 2

Example 2
Input: @list = (3)
Output: 0
=end comment

sub ct-max-adjace-diff( @list --> Int) {
    when @list.elems == 1 { 0 };
    when @list.elems == 2 { 1 };
    (
        map { abs( $_[0] - $_[1])}, @list.sort.rotor( 2 => -1)
    ).Bag.max.value;
}

sub MAIN () {

    my @Test =
        { in => (2,5,8,1),    exp => 2, },

        { in => (5,),         exp => 0, },
        { in => (1,0),        exp => 1, },

        { in => (10,10,10),   exp => 2, },
        { in => (1,10,10),    exp => 1, },
        { in => (10,1,1),     exp => 1, },
        { in => (10,10,1),    exp => 1, },

        { in => (2,4,6,8),    exp => 3, },
        { in => (2,4,6,7),    exp => 2, },
        { in => (2,3,5,7),    exp => 2, },
        { in => (3,6,7,10),   exp => 2, },
        { in => (7,8,12,13),  exp => 1, },
        { in => (6,10,12,13), exp => 1, },
        { in => (9,11,12,13), exp => 1, },

        { in => (1,3,5,7,9),  exp => 4, },
        { in => (1,2,4,6,8),  exp => 3, },
        { in => (1,3,4,6,8),  exp => 3, },
        { in => (1,3,5,6,8),  exp => 3, },
        { in => (1,3,5,7,8),  exp => 3, },
        { in => (1,3,5,6,7),  exp => 2, },
        { in => (1,3,4,6,7),  exp => 2, },
        { in => (1,3,4,5,7),  exp => 2, },
        { in => (1,2,4,6,7),  exp => 2, },
        { in => (1,2,4,5,7),  exp => 2, },
        { in => (1,2,3,5,7),  exp => 2, },
        { in => (1,3,4,5,6),  exp => 1, },
        { in => (1,2,4,5,6),  exp => 1, },
        { in => (1,2,3,5,6),  exp => 1, },
        { in => (1,2,3,4,6),  exp => 1, },

        { in => (0,0,1,1,3,3,5,5,7),             exp => 3, },
        { in => (0,0,0,0,0,0,0,0,0,0,2,2,2,2,4), exp => 2, },
    ;
    plan 4 * @Test;
    for @Test -> %t {
        my $got = ct-max-adjace-diff( %t<in>);
        is $got, %t<exp>, "$got <- %t<in>";
        for 1..3 {
            my @in = %t<in>.pick(*);
            $got = ct-max-adjace-diff( @in);
            is $got, %t<exp>, "$got <- @in[] shuffle";
        }
    }
    done-testing;

    my @list = (1,3,4,6,8).pick(*);
        { in => (1,3,4,6,8),  exp => 3, },
    say "\n\nInput:  @list = @list[]\n"
      ~ "Output: ", ct-max-adjace-diff( @list);
}
