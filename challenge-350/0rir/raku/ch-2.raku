#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
350-Task 2: Shuffle Pairs       Submitted by: E. Choroba
If two integers A <= B have the same digits but in different orders, we say that they belong to the same shuffle pair if and only if there is an integer k such that B = A * k where k is called the witness of the pair.

For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 = 9513.

Interestingly, some integers belong to several different shuffle pairs. For example, 123876 forms one shuffle pair with 371628, and another with 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.

Write a function that for a given $from, $to, and $count returns the number of integers $i in the range $from <= $i <= $to that belong to at least $count different shuffle pairs.

PS: Inspired by a conversation between Mark Dominus and Simon Tatham at Mastodon.

=end comment

my @Test =
    # low       hi      min-count       exp
    1,          1000,           1,      0,
    1500,       2500,           1,      3,
    1_000_000,  1_500_000,      5,      2,
    13_427_000, 14_100_000,     2,      11,
    1030,       1130,           1,      2,
;
plan +@Test ÷ 4;

my subset PInt of Int where { $_ > 0 }

multi XXtaskXX( PInt:D $low, PInt:D $hi where * > $low, UInt:D $min-match-ct) {
    my Str $ref;
    my $limit;
    my $ret = 0;

    for $low … $hi -> $num {
        $ref = $num.comb.sort.join;
        $limit = 10**$num.chars;
        ++$ret if  $min-match-ct ≤ count-shu-pairs( [$num, $limit, $ref]); 
    }
    return $ret;
}

multi task( PInt:D $low, PInt:D $hi where * > $low, UInt:D $min-match-ct) {
    my Str $ref;
    my $limit;
    my $ret = 0;
                sub mk-params4num($n ) {
                    # NUM   LIMIT           REF
                    [ $n,   10**$n.chars,   $n.comb.sort.join];
                }

                sub calc4num( @in --> Int:D) {
                    return 1 if  count-shu-pairs( @in ) ≥ $min-match-ct;;
                    0;
                }
    my @data = ($low … $hi )».&mk-params4num;
    sum do hyper for @data -> @p { calc4num( @p) }
    
}
enum count-shu-pairs-idx < NUM LIMIT REF >;
sub count-shu-pairs(  @param --> Int:D) {
    my $ret = 0;
    for 2..9 -> \mult {
        last unless mult × @param[NUM] < @param[LIMIT];
        ++$ret if  (mult × @param[NUM]).comb.sort.join eq @param[REF];
    }
    return $ret;
}

for @Test -> $in, $hi, $min, $exp {
    is task( $in, $hi, $min), $exp, "{$exp // $exp.^name()} <- $in…$hi, $min";
}
done-testing;

my $from = 1030;
my $to = 1130;
my $count = 1;
say qq{\nInput: \$from = $from, \$to = $to, \$count = $count}
  ~ qq{\nOutput: }, task $from, $to, $count;

