#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
367-2: Conflict Events          Submitted by: Mohammad Sajid Anwar
You are given two events start and end time.
Write a script to find out if there is a conflict between the two events.
A conflict happens when two events have some non-empty intersection.
=end comment

my @Test =
    #   Event1              Event2          Exp
    <10:00 12:00>,      <11:00 13:00>,     True,
    <09:00 10:30>,      <10:30 12:00>,     False,
    <14:00 15:30>,      <14:30 16:00>,     True,
    <08:00 09:00>,      <09:01 10:00>,     False,
    <23:30 00:30>,      <00:00 01:00>,     True,

    <23:30 00:00>,      <00:00 01:00>,     False,
;
plan +@Test ÷ 3;

# Fold the timestr into an integer which is only good for comparisons.
sub hh-mm2num( Str:D() $hh-mm -->Int:D) { $hh-mm.split( ':').join.Int }

sub task( @ev1, @ev2 -->Bool) {
    my @tim = @ev1[1], @ev2[0];
    @tim.=map: {  hh-mm2num($_) };
    return True if @tim[1] < @tim[0];
    False;
}

use Test;
for @Test -> @in1, @in2, $exp {
    is task( @in1, @in2), $exp,
         "{$exp // $exp.^name()}\t<- @in1.raku() ∘∘ @in2.raku()";
}
done-testing;

my @event1 = ("10:00", "12:00");
my @event2 = ("11:00", "13:00");

say qq{\nInput: @event1 = ("@event1.join( '", ')")\n},
      qq{       @event2 = ("@event2.join( '", ')")\n},
      qq{Output: }, lc task @event1, @event2;
