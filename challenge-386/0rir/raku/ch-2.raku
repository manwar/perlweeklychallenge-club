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
    #  $a           $b              $exp
    "0.(12)",       "0.(121)",      False,
    "0.1(23)",      "0.12(32)",     True,
    "0.1(234)",     "0.12(342)",    True,
    "12.99(99)",    "13.",          False,  # doubles don't contain all rats
    "0.(123)",      "0.1(231)",     True,
    "1",            "1",            True,
;
plan +@Test ÷ 3;

    

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

enum Part < Int Fract Repit>;
sub task( Str $a is copy, Str $b is copy -->Bool) {
   return True if $a eq $b;

    my ( %a, %b);
    (%a<int>, %a<fract>, %a<rep>) = $a.split( /<[.()]> /);
    (%b<int>, %b<fract>, %b<rep>) = $b.split( /<[.()]> /);
    return False unless %a<int> eq %b<int>;

    ( %a<fract>, %a<rep>) = shrink( %a<fract>, %a<rep>);
    ( %b<fract>, %b<rep>) = shrink( %b<fract>, %b<rep>);

    return True if  %a<fract> ~ %a<rep> eq %b<fract> ~ %b<rep>;

    when %a<fract> eq %b<fract> {
        return %a<rep> × %b<rep>.chars eq %b<rep> x %a<rep>.chars;
    }
    return Bool;
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

