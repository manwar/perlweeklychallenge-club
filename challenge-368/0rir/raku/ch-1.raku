#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
368-1: Make it Bigger          Submitted by: Mohammad Sajid Anwar
You are given a given a string number and a character digit.

Write a script to remove exactly one occurrence of the given character digit from the given string number, resulting the decimal form is maximised.
=end comment

=begin query
    Two things.
      1) Negative numbers are not explicitly excluded.  The bookkeeping to
    handle negatives is not interesting, so I'll accept the examples
    as well representing the domain.
      2) The weird case is a string of one digit; that resulting empty string
    may be considered out of bounds or zed.  This is murky, I choose zed vs
    dying, arbitrarially; this to allow single char strings.
=end query

my @Test =
    "15456",    "5",    "1546",
    "7332",     "3",    "732",
    "2231",     "2",    "231",
    "543251",   "5",    "54321",
    "1921",     "1",    "921",
    "2222",     "2",    "222",
    "212121",   "2",    "21211",
    "21212",    "2",    "2121",
    '1',        '1',    '0',        # ???
;
my @Dead = "12341",  '5';
plan +@Dead + 2 × +@Test ÷ 3;

sub task-Ary( Str:D(Int()) $in, Int:D() $char -->Str) {
    my @ret;
    my @in = $in.comb;
    my @k = @in.grep(:k,  $char);
    for @k -> \k {
       @ret.push( [flat @in.[^k,k^..^@in]].join)
    }
    @ret.max[0] eq '' ?? '0' !! @ret.max[0]
}

sub task-Str( Str(Int:D())$in where *.chars > 0, Int:D() $char --> Str:D) {
    my $ret;
    my $candi;
    for 1...∞ -> \i {
        if $in eq my $c = $in.subst($char, '', :nth(i)) {
            last;
        } else {
            $candi = $c if ! defined $candi or $candi < $c;
        }
    }
    die 'No match' if not defined $candi;
    $candi = $candi eq ''  ?? '0' !! $candi.Str;    # NOTE: see query above.
}

for @Dead -> $in, $char {
    dies-ok { task-Ary( $in, $char) }, "dies $in∘∘$char";
    dies-ok { task-Str( $in, $char) }, "dies $in∘∘$char";
}
for @Test -> $in, $char, $exp {
    is task-Ary( $in, $char), $exp, "{$exp // $exp.^name()} <- $in∘∘$char";
    is task-Str( $in, $char), $exp, "{$exp // $exp.^name()} <- $in∘∘$char";
}
done-testing;

my $str = "1921";
my $char = "1";

say qq{\nInput: \$str = "$str", \$char = "$char"\nOutput: "},
        task-Ary($str,$char), '"';
