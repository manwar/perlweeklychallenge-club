# https://oeis.org/A001318
sub positive_and_negative ( UInt $n          ) { |( +$n, -$n ) }
sub pentagonal            (  Int $n --> UInt ) { $n * ( 3 * $n - 1 ) div 2 }
constant @A001318 = (1 .. Inf).map(&positive_and_negative).map(&pentagonal);

# PartitionsP uses A001318 in this pattern of signs: ++--++--++-- …
constant @A001318_to_add      = flat @A001318.skip(0).rotor(2 => 2);
constant @A001318_to_subtract = flat @A001318.skip(2).rotor(2 => 2);

# https://oeis.org/A001318/
constant @PartitionsP = 1, -> *@P {
    @P[+@P X- @A001318_to_add     ].sum
  - @P[+@P X- @A001318_to_subtract].sum
} … *;

sub task2 ( UInt $n ) { return @PartitionsP[$n] }


multi sub MAIN ( Bool :$OEIS ) { say "$_ {.&task2}" for 0..10_000 }
multi sub MAIN ( UInt $n     ) { say task2($n) }
multi sub MAIN ( Bool :$test ) {
    use Test;
    plan 3;
    is task2(  5), 7;
    is task2(666), 11956824258286445517629485;
    is-deeply @PartitionsP.head(26),
             +«<1 1 2 3 5 7 11 15 22 30 42 56 77 101 135 176 231 297 385 490 627 792 1002 1255 1575 1958>;
}
# `ch-2.raku --OEIS` produces exact match of the 10_000 values
# at https://oeis.org/A001318/b001318.txt , in 35 seconds.
# This is twice as fast as Perl's ntheory module, even when it is using GMP!
# Yet another instance of where Raku shines,
# when the design (`Sequences` this time) exactly matches a use case.

# Illustration at 14m54s of:
# https://youtu.be/iJ8pnCO0nTY?t=894
# The hardest "What comes next?" (Euler's pentagonal formula)


# By the way, I attempted to translate the fastest known method,
#    Hardy-Ramanujan-Rademacher formula
#    https://fungrim.org/topic/Partition_function/
#    https://fungrim.org/entry/fb7a63/
# , from http://www.flintlib.org/ into Raku,
# but my code returned zero for every input,
# so clearly I did something wrong!
