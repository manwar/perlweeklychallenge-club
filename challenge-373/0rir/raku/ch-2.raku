#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
INIT $*RAT-OVERFLOW = FatRat;
use lib $?FILE.IO.cleanup.parent(2).add("lib");
use Test;

=begin comment
May be edited for space.
373-Task 2: List Division   Submitted by: Mark Anderson
You are given a list and a non-negative integer.

Write a script to divide the given list into given non-negative integer equal parts. Return -1 if the integer is more than the size of the list.
=end comment


my @Test =
    # in                        divr  exp
(1,2,3,4,5),                      2, ((1,2,3), (4,5)),
(1,2,3,4,5,6),                    3, ((1,2), (3,4), (5,6)),
(1,2,3),                          2, ((1,2), (3)),
(1,2,3,4,5,6,7,8,9,10),           5, ((1,2), (3,4), (5,6), (7,8), (9,10)),
(1,2,3),                          4, -1,
(72,57,89,55,36,84,10,95,99,35),  7,
            ((72,57), (89,55), (36,84), (10), (95), (99), (35)),
;
plan +@Test ÷ 3;

constant \task_ERROR = -1;       # something OOB

sub infix:<%%%>( $a, $b -->List) { ($a div $b), ($a % $b) }

multi task( Array:D() $a, Int:D() $chk-ct where * > $a.elems) { task_ERROR }
multi task( Array:D() $a, Int:D() $chk-ct -->List:D) {
    my ($dend, $rem) = $a %%% $chk-ct;

    given $rem {
        when 0  { $a.rotor( $dend).Array }
        default {
            my $tail-head = $rem × $dend + $rem;
            ( $a[^$tail-head   ].rotor( $dend +1).Array.append(
                   $a[ $tail-head ..^@$a].rotor( :partial, $dend).Array)
            ).List;
        }
    }
}

for @Test -> $a, $n, $exp {
    is task( $a, $n), $exp, "{$exp.raku() // $exp.^name()} <- $n ∘∘ $a.raku()";
}
done-testing;

my @list = (72,57,89,55,36,84,10,95,99,35);
my $n = 7;

say qq{\nInput: @list = (@list.join(',')), \$n = $n;\n}
  ~ qq{Output: }, task( @list, $n).raku();
