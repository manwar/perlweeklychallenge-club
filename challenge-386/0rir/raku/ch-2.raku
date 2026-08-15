#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
386-2: Rational Numbers    Submitted by: Mohammad Sajid Anwar

You are given two strings representing non-negative rational numbers.
Write a script to return true if the two given rational numbers are
same otherwise false.
Example

Input: $rat1 = "0.1(23)"
       $rat2 = "0.12(32)"
Output: true
=end comment

my @Test =
    #  $a         $b                $exp
    "0.(12)",     "0.(121)",        False,
    "0.1(23)",    "0.12(32)",       True,
    "0.1(234)",   "0.12(342)",      True,
    "12.99(99)",  "13.",            False,  # doubles don't contain all rats
    "0.(123)",    "0.1(231)",       True,
    "1",          "1",              True,
    "0.1(234)",   "0.1234234(234)", True,
    ".1(234)",    "0.1234234(234)", True,
;
plan +@Test ÷ 3;


enum Part <Whole Fract Repet>;
# Reduce the fraction while tails match, move rep tail to its head. 
#         Fract  Rep                    Fract      Rep
# initial "12"  "32"           ||    '123456'   '7456'
# deleted "1"   "3"            ||
# moved   "1", "23" done       ||    '123'   '4567'
sub shrink( $fract is copy , $rep is copy -->List) {
    loop {
        last unless   $fract.chars > 0
                  and $fract.substr(*-1) eq $rep.substr( *-1);
        $rep = $rep.substr(*-1) ~ $rep.substr( 0,*-1);
        $fract.=substr(0, *-1);
    }
    return ( $fract, $rep);
}

sub task( Cool:D $a is copy, Cool:D $b is copy -->Bool) {

            # a class could clean up the doubled code  ben

    return True if $a eq $b;   # covers undef in Fract and Repet

        # .new
    my ( @a, @b);
    (@a[Whole], @a[Fract], @a[Repet]) = $a.split( / <[.()]> /);
    (@b[Whole], @b[Fract], @b[Repet]) = $b.split( / <[.()]> /);

    @a[Whole] = '0' if @a[Whole] eq '';
    @b[Whole] = '0' if @a[Whole] eq '';

    return False unless @a[Whole].Int == @b[Whole];
        # .TWEAK
    ( @a[Fract], @a[Repet]) = shrink( @a[Fract], @a[Repet]);
    ( @b[Fract], @b[Repet]) = shrink( @b[Fract], @b[Repet]);
        # eqv(T,T)
    return False unless @a[Whole] eq @b[Whole];
    return True if  @a[Fract] ~ @a[Repet] eq @b[Fract] ~ @b[Repet];
    when @a[Fract] eq @b[Fract] {
        return @a[Repet] × @b[Repet].chars eq @b[Repet] x @a[Repet].chars;
   }
  return False;
}

for @Test -> $a, $b, $exp {
    is task( $a, $b), $exp, "$exp <- $a ∘∘ $b";
}
done-testing;

my $rat1 = "0.1(234)";
my $rat2 = "0.12(342)";

say qq{\nInput: \$rat1 = "$rat1"
       \$rat2 = "$rat2"
Output: }, task $rat1, $rat2;

