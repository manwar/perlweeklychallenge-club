#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

constant \XT = False;

=begin comment
May be edited for no good reason:
397-2: Binary Reflection        Submitted by: Mohammad Sajid Anwar
You are given an array of integer.
Write a script to sort the given array in ascending order based on the binary reflection of each element. If two different numbers have the same binary reflection, the smaller original number should appear first.
=end comment

my @Test =
    (3, 6, 12),             (3, 6, 12),
    (1, 2, 4, 8),           (1, 2, 4, 8),
    (-1, -2, -4, -8),       (-8, -4, -2, -1),
    (7, 8, 9, 10),          (8, 10, 7, 9),
    (5, 9, 15, 17),         (5, 9, 15, 17),
    (11, 13, 14, 19),       (14, 13, 11, 19),
    (-11, -13, -14, -19),   (-19, -11, -13, -14),
;

my @Reflect-test =
    1, 1,       2, 1,       3, 3,       4, 1,       5, 5,
    6, 3,       7, 7,       8, 1,       9, 9,       10, 5, 
    11, 13,     12, 3,      13, 11,     14,7,       15,15,
    16, 1,      17, 17,     19, 25,     25,19,
;

plan ( @Test + ( XT × 2 × @Reflect-test) ) ÷ 2;

# Give the Int that is the binary mirror of input.  Allowing negative Ints.
sub binary-reflect( Int:D() $i -->Int:D ) {
     my $ret = ( $i.abs.base(2).flip).parse-base(2); 
    $i < 0 ?? -$ret !! $ret;
}

sub task( $a) {
    $a.sort: { .&binary-reflect, .self };
}

if XT {
    subtest 'binary-reflect', {
        for @Reflect-test -> $in, $exp {
            is binary-reflect($in), $exp, "reflect $in -> $exp";
            is binary-reflect(-$in), -$exp, "reflect -$in -> -$exp";
        }
    }
}
for @Test -> $in, $exp  {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()"
}
done-testing;

my @arr = (-32..32).pick( ( 5..8).pick);

say qq{\nInput: @arr = ({@arr.join(', ')})}
    ~ "\nOutput: (", task(@arr).join(', '),')';

