#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴
use v6.d;
use Test;

=begin comment
291-1: Middle Index             Submitted by: Mohammad Sajid Anwar
You are given an array of integers, @ints.

Write a script to find the leftmost middle index (MI) i.e. the smallest amongst all the possible ones.

A middle index is an index where ints[0] + ints[1] + … + ints[MI-1] == ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].

If MI == 0, the left side sum is considered to be 0. Similarly,
if MI == ints.length - 1, the right side sum is considered to be 0.
Return the leftmost MI that satisfies the condition, or -1 if there is no such index.

Example 1
Input: @ints = (2, 3, -1, 8, 4)
Output: 3

The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
The sum of the numbers after index 3 is: 4 = 4
Example 2
Input: @ints = (1, -1, 4)
Output: 2

The sum of the numbers before index 2 is: 1 + -1 = 0
The sum of the numbers after index 2 is: 0
Example 3
Input: @ints = (2, 5)
Output: -1

There is no valid MI.
=end comment

my @Test =
    (2, 3, -1, 8, 4),   3,
    (1, -1, 4),         2,
    (2, 5),             Int,
    (5, -1, 1),         0,
    (-1, 1, 5),         2,
    (0,0),              0,
    (0,),               0,
;

my @Die = (), @;

plan 2 * ( +@Die + @Test ÷ 2);

# .sum and sum for head and tail
multi task-sum( [] ) { die 'No elements found' }
multi task-sum( @a) {
    return 0 if 0 == sum @a[1..^@a];
    for 1..^(-1+@a) -> \i {
        return i if @a[ 0..^i].sum == sum @a[ i^..^@a];
    }
    return @a-1 if 0 == sum @a[0..^(@a -1)];
    return Int;
}

# [+] for head and tail
multi task-plus( [] ) { die 'No elements found' }
multi task-plus( @a) {
    return 0 if 0 == [+] @a[1..^@a];
    for 1..^(@a-1) -> \i {
        return i if ([+] @a[ 0..^i]) == [+] @a[ i^..^@a];
    }
    return @a-1 if 0 == [+] @a[0..^(@a -1)];
    return Int;
}

# transfer difference from head to tail
multi task-xfer ( [] )  { die 'No elements found' }
multi task-xfer ( @a )  { 
    my $i = 0;
    my ( $l, $r);
    while $i < @a {
        once ( $l, $r) = 0, sum @a[1..^@a];
        return $i if $l == $r;
        $l += @a[$i];
        $r -= @a[++$i] // 0 ;
    }
    return $i if $l == $r;
    return Int;
}

for ( &task-plus, &task-xfer) -> &t {
    for @Test -> @in, $exp {
        is t(@in), $exp, ( $exp // 'Int') ~ " <- @in.raku()";
    }
    for @Die -> @in {
        dies-ok { t(@in) }, "@in.raku() dies.";
    }
}
done-testing;

my @int = 1,0,5,4,7,1,-5,0,7,10,-7;
say "\nInput: @int = @int.raku()\nOutput: ", task-xfer( @int) // -1;

#=finish

use Bench;
my $b = Bench.new;

my @i =  (( 50, ( *-1 ) ...1), 0,( 1...50)).flat;

'---------------------------------------------------------'.say;
$b.cmpthese(1000, {
  sum  => sub { task-sum(  @i) },
  plus => sub { task-plus( @i) },
  xfer => sub { task-xfer( @i) },
});
