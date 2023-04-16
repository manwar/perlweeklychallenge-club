#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
212-1: Jumping Letters          Submitted by: Mohammad S Anwar
Given a word having only alphabetic characters and a list of positive
integers of the same length print the new word generated after jumping
forward each letter in the given word by the integer in the list.

Example 1
Input: $word = 'Perl' and @jump = (2,22,19,9)
Output: Raku

'P' jumps 2 place forward and becomes 'R'.
'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z'
        you go back to 'a')
'r' jumps 19 place forward and becomes 'k'.
'l' jumps 9 place forward and becomes 'u'.
Example 2
Input: $word = 'Raku' and @jump = (24,4,7,17)
Output: 'Perl'
=end comment

my @Test =
    'Perl',     (2,22,19,9),    'Raku',
    'vWxYz',    (5,5,5,5,5),    'aBcDe',
    'abc',      (1,2,3),        'bdf',
;
plan @Test ÷ 3;

class Rot-n {
    has Any $.abc is required; # a ring-table of the alphabet in use
    has Int $!elems;    # of $.abc
    has Any %!index;    # kv,s of abc

    method key-of( $char ) { %!index{$char.lc} }
    method val-of( UInt $idx ) {  $!abc[$idx % $!elems];}

    method new( @alphabet){ ::?CLASS.Mu::new( abc => @alphabet ); }
    method TWEAK { $!elems = $!abc.elems; %!index = $!abc.antipairs; }

    # rotate each char in $in by zip sister in @offset
    method rot-n( Str $in, @offset where *.elems == $in.chars -->Str) {
        my Str @orig = [$in.comb];
        my @return =  @orig;
        for ^@return -> $i {
            @return[$i] = $.val-of( $.key-of(@return[$i]) + @offset[ $i]);
            @return[$i] = @orig[$i] eq @orig[$i].uc
                          ??           @return[$i].uc
                          !!           @return[$i];
        }
        return @return.join;
}   }


my Rot-n $r = Rot-n.new( 'a'...'z' );

for @Test -> $in, @offset, $exp {
    is $r.rot-n( $in, @offset), $exp,  "$in --> $exp";
}
done-testing;


my $word = 'Perl';
my @jump = (2,22,19,9);

say "\nInput: $word = 'Perl' and @jump = @jump.raku()
Output: $r.rot-n($word, @jump)";
