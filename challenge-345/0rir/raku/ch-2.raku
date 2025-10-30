#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
Edited for space.
345-Task 2: Last Visitor        Submitted by: Mohammad Sajid Anwar
You are given an integer array @ints where each element is either a positive integer or -1.

We process the array from left to right while maintaining two lists:

@seen: stores previously seen positive integers (newest at the front)
@ans: stores the answers for each -1
Rules:

If $ints[i] is a positive number -> insert it at the front of @seen
If $ints[i] is -1:
Let $x be how many -1s in a row we’ve seen before this one.

If $x < len(@seen) -> append seen[x] to @ans

Else -> append -1 to @ans

At the end, return @ans.

=end comment

my @Test =
    (5, -1, -1),                (5, -1),
    (3, 7, -1, -1, -1),         (7, 3, -1),
    (2, -1, 4, -1, -1),         (2, 4, 2),
    (10, 20, -1, 30, -1, -1),   (20, 30, 20),
    (-1, -1, 5, -1),            (-1, -1, 5),

    (1,2,3),                    (),
    (-1,),                      (-1,),
    (-1,-1,-1),                 (-1,-1,-1),
;
plan +@Test ÷ 2;

my subset PosInt of Int where { $_ > 0}

sub task( @a) {
    my (@seen, @ret);
    my $x = -1;

    for @a -> $e {
        given $e  {
            when PosInt {
                @seen.unshift: $e;
                $x = -1;
            }
            when -1 {
                @ret.push: ++$x < @seen ?? @seen[$x] !! -1;
            }
            default {
                die "Value '$e' is illegal";
            }
        }
    }
    @ret;
}

for @Test -> @in, @exp {
    is task( @in), @exp, "{@exp.raku // @exp.^name()} <- @in.raku()";
}
done-testing;

my @int = (2, -1, 4, -1, -1);

say "\nInput: @int = ({@int.join( ', ')})"
  ~ "\nOutput: ({task(@int).join: ', '})";
