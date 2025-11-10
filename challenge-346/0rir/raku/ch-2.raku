#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
346-2: Magic Expression         Submitted by: Mohammad Sajid Anwar
You are given a string containing only digits and a target integer.

Write a script to insert binary operators +, - and * between the digits in the given string that evaluates to target integer.
=end comment

my @Test =
    "",         0, (),
    "1",        2, (),
    "1",        1, ("1",),
    "015",      6, ("0+1+5",),
    "015",      4, ("0-1+5",),
    "015",     -4, ("0+1-5",),
    "015",     -5, ("0*1-5", "0-1*5",),
    "015",     -6, ("0-1-5",),
    "015",    -15, ("0-15",),
    "015",     15, ("0+15",),
    "015",      0, ("0*1*5", "0*15"),
    "123",      6, ("1*2*3", "1+2+3"),
    "105",      5, ("1*0+5", "10-5"),
    "232",      8, ("2*3+2", "2+3*2"),
    "1234",    10, ("1*2*3+4", "1+2+3+4"),
    "1001",     2,
            ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"),
    "101011",  2,
            ('1*0*1*0+1+1 1*0*1+0+1+1 1*0*1-0+1+1 1*0*10+1+1 1*0+1*0+1+1 1*0+1+0*1+1 1*0+1+0+1*1 1*0+1-0*1+1 1*0+1-0+1*1 1*0-1*0+1+1 1+0*1*0*1+1 1+0*1*0+1*1 1+0*1+0*1+1 1+0*1+0+1*1 1+0*1-0*1+1 1+0*1-0+1*1 1+0*10*1+1 1+0*10+1*1 1+0+1*0*1+1 1+0+1*0+1*1 1+0+1+0*1*1 1+0+1+0*11 1+0+1+0+1-1 1+0+1+0-1+1 1+0+1-0*1*1 1+0+1-0*11 1+0+1-0+1-1 1+0+1-0-1+1 1+0-1*0*1+1 1+0-1*0+1*1 1+0-1+0+1+1 1+0-1-0+1+1 1+0-10+11 1-0*1*0*1+1 1-0*1*0+1*1 1-0*1+0*1+1 1-0*1+0+1*1 1-0*1-0*1+1 1-0*1-0+1*1 1-0*10*1+1 1-0*10+1*1 1-0+1*0*1+1 1-0+1*0+1*1 1-0+1+0*1*1 1-0+1+0*11 1-0+1+0+1-1 1-0+1+0-1+1 1-0+1-0*1*1 1-0+1-0*11 1-0+1-0+1-1 1-0+1-0-1+1 1-0-1*0*1+1 1-0-1*0+1*1 1-0-1+0+1+1 1-0-1-0+1+1 1-0-10+11 10*1*0+1+1 10-10+1+1'),
;

plan +@Test ÷ 3;

my @deffed-op = '', '*', '-', '+';      # '' is not an op; is to concat digits.
my @real-op   =     '*', '-', '+';
my regex ops { @deffed-op };

multi task( Str:D $a where * eq "",      Int:D $goal -->Array) { [] }
multi task( Str:D $a where *.chars == 1, Int:D $goal -->Array) {
    return [] unless $a.Int == $goal;
    [$a,]
}
#   1)  Move '' out of deffed ops to separately furcate the problem by size of the
#       integer arrays.  Delete leading zero candidates early.
#   2)  A zero can split the array into sub problems where the solutions cannot be
#       unknown until all subarrays are done.
#   3)  A run of zeds create a batch of strings but one candidate sub-target. No math.

multi task( Str:D $a, Int:D $goal  -->Array) {
    my @oper = lazy [ [X] @deffed-op xx $a.chars -1 ].map: *.Array;

=begin bug-query
   my @ret = do hyper for @oper -> @op {
A worker in a parallel iteration (hyper or race) initiated here:
  …
Died at:
    Cannot unbox a type object (NQPMu) to int.
      in block  at ch-2.raku line 53
=end bug-query

    my @ret = do for @oper -> @op {
        @op.push: '';
        my $formula = ( [ [Z] $a.comb, @op ].flat: :hammer ).join;
            # Remove zeds prefacing integer operands.
        next if $formula ~~ m/ || [ <ops>           '0'+        <[1..9]> ]
                               || [ [ <ops> || ^ ]  '0'**2..*   <ops>    ] /;
       $formula if $goal == EVAL $formula;
    }
    @ret;
}

for @Test -> $in, $goal, $exp {
    is task( $in, $goal).sort, $exp, "{$exp // $exp.^name()} <- $goal ∘∘ $in.raku()";
}

my $str = "1001";
my $target = 2;

say qq{\nInput: \$str = "$str", \$target = $target}
   ~qq{\nOutput: (}, &task( $str, $target).join("\", \""), '")';
=finish
