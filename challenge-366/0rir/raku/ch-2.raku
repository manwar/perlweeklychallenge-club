#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
366-2: Valid Times          Submitted by: Mohammad Sajid Anwar
You are given a time in the form ‘HH:MM’. The earliest possible time is
‘00:00’ and the latest possible time is ‘23:59’. In the string time, the
digits represented by the ‘?’ symbol are unknown, and must be replaced
with a digit from 0 to 9.

Write a script to return the count different ways we can make it a valid time.
=end comment

my @Test =
    #  in         exp
    "?2:34",       3,
    "?4:?0",      12,
    "??:??",    1440,
    "10:??",      60,
    "10:?5",       6,

    "??:1?",     240,
    "??:?1",     144,
    "??:11",      24,
    "11:1?",      10,
    "0?:11",      10,
    "1?:11",      10,
    "2?:11",       4,
    "?3:11",       3,
    "?4:11",       2,
    "?9:11",       2,
    "11:11",       0,
;
plan +@Test ÷ 2;

my regex valid-time {
    ^   [ <[01?]>   <[0..9?]> ] || [ <[2?]>    <[0123?]> ]
        ':'
        <[0..5?]>  <[0..9?]>
    $
}

# Give Str simple zero-based array-ish syntax.
multi postcircumfix:<[ ]>( Str:D \a, Int \i -->Str:D) { substr(a, i, 1) }
multi postcircumfix:<[ ]>(
    Str:D \a,
    Range \r where { .min > -1 and .min == .min.Int } -->Str:D)
{
    substr( a, r.min..r.max -r.min);
}

sub task( Str $in where { / <valid-time> /}  -->Int:D) {
   my $ret = 1;                 # multiplicative identity and out of band
   {
        if   $in[3]    eq '?'  { $ret ×=  6 }
        if   $in[4]    eq '?'  { $ret ×= 10 }
        when $in[0..1] eq '??' { $ret ×= 24 }
        when $in[0]    eq '?'  { $ret ×= $in[1] <  4 ??  3 !! 2 }
        when $in[1]    eq '?'  { $ret ×= $in[0] <  2 ?? 10 !! 4 }
   }
   $ret == 1 ?? 0 !! $ret;
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in";
}
done-testing;

my $time = "2?:15";
say qq{\nInput: \$time = "$time"\nOutput: }, task $time;
