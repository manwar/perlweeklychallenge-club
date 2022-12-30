#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use Test;

=begin comment
197-2: Wiggle Sort          Submitted by: Mohammad S Anwar
Given a list of integers, @list, perform a Wiggle Sort on it, this will make
a list where the following is true: list[0] < list[1] > list[2] < list[3]….

Example 1
Input: @list = (1,5,1,1,6,4)
Output: (1,6,1,5,1,4)
Example 2
Input: @list = (1,3,2,2,3,1)
Output: (2,3,1,3,1,2)
=end comment

multi wiggle( [] --> Array) { die 'Nothing to wiggle!' }
multi wiggle( @a is copy --> Array ) {
    my $b = @a.Bag;
    die 'Impossible wiggle!' if $b.values.max ≥ ($b.total/2)+1;
    @a.=sort;
    my $mid = @a.elems ÷ 2;

    if $mid == $mid.Int {
        @ = flat [Z] @a[0..^$mid], @a[$mid..@a.end];
    }else{
        $mid.=floor;
        (@ = flat [Z] @a[0..^$mid], @a[1+$mid..@a.end]).push(@a[$mid]);
    }
}

my @Die = [], [1,1,1,2], [0,0,0,0,2,2], [-1,-1,-1,-1,-1,2,2];

my @Test =
    { in => [1,],             exp => [1,],              },
    { in => [1,2],            exp => [1,2],             },
    { in => [2,1],            exp => [1,2],             },
    { in => [-1,2,-3,4],      exp => [-3,2,-1,4],       },
    { in => [0,-1,2,-3,4],    exp => [-3,2,-1,4,0],     },
    { in => [1,2,3,4],        exp => [1,3,2,4],         },
    { in => [1,5,1,1,6,4],    exp => [1,4,1,5,1,6],     },
    { in => [1,3,2,2,3,1],    exp => [1,2,1,3,2,3,],    },
    { in => [1,1,1,2,2],      exp => [1,2,1,2,1],       },
    { in => [1,2, 3, 4,5],    exp => [1,4,2,5,3,],      },
    { in => [1,5,1,1,6,4,2],  exp => [1,4,1,5,1,6,2],   },
    { in => [1,1,1,1 ,2,2,2], exp => [ 1,2,1,2,1,2,1],  },
    { in => [1...10],         exp => [ flat (1…5) Z (6…10)],},
    { in => [1...1000],       exp => [ flat (1…500) Z (501…1000)],}, 
    { in => [1...60000],      exp => [ flat (1…30000) Z (30001…60000)],}, 
 #{ in => [1...100000],     exp =>[ flat (1…50000) Z (50001…100000)],},
 # Flattened array has 100000 elements, but argument lists are limited to 65535
;

plan +@Test + @Die;
for @Die -> @a {
    dies-ok { wiggle( @a) }, " dies on " ~ ( @a[].Str or '[]' );
}
for @Test -> %t {
    is-deeply  wiggle(%t<in>), %t<exp>, " -> %t<exp>.gist()";
}


my @list = [1...10];
say "
    Input: @list = @list.raku()
    Output:        ", wiggle(@list).raku();

die 'by programmer stupidity' unless wiggle(@list) ~~ [ flat (1…5) Z (6…10)];
done-testing;
