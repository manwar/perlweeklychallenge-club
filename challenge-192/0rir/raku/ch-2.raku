#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
192-2: Equal Distribution            Submitted by: Mohammad S Anwar
Given a list of integers greater than or equal to zero, @list, distribute the
values so that all elements are same.
If you succeed then print the total moves otherwise print -1.

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00]

1) You can only move a value of '1' per move
2) You are only allowed to move a value of '1' to a direct neighbor/adjacent cell

Example 1:
Input: @list = (1, 0, 5)
Output: 4

Example 2: Input: @list = (0, 2, 0) Output: -1
Example 3: Input: @list = (0, 3, 0) Output: 2
=end comment

=comment    Sorry: I am not tapping each circle as I go round the board.

class Equalizer {
    has       @.people is rw;
    has Pair  $!rich;
    has Pair  $!poor;
    has Int   $!mean;
    has Int   $!h      = 0;
    has Int   $!t;
    has Int   $!effort = 0;

    submethod TWEAK {
       die 'Got Empty array.' if @!people ~~ Empty;
        $!t = @!people.elems;
        my $ave = ( ([+] @!people) ÷ $!t-- );
        $!mean = $ave.Int == $ave ?? $ave.Int !! Int ;
    }
    method swap( ) {
        my $need    = $!mean       - $!poor.value;
        my $surplus = $!rich.value - $!mean;
        my $amt =  ($need, $surplus).min;
        $!rich.value -= $amt;
        $!poor.value += $amt;
        $!effort += $amt × abs( $!rich.key - $!poor.key);
    }
    method redistribution( --> Int) {
        return Int if  not defined $!mean;
        return 0 if $!mean == 0;
        loop {
            $!rich = @.people[$!h..$!t].first( * > $!mean, :kv).pairup[0].Pair;
            $!poor = @.people[$!h..$!t].first( * < $!mean, :kv).pairup[0].Pair;
            last unless  $!rich.defined and $!poor.defined;
            $!h = ($!rich.key, $!poor.key).min;
            self.swap;
        }
        $!effort;
    }
}

multi MAIN ( @list = [ 1, 0, 5] ) {
    my $c = Equalizer.new( people => @list );
    $c = $c.redistribution;
    $c = $c.defined ?? $c !! Int;
    say "Input: \@list = @list.raku()\nOutput: $c.raku()";
}

multi MAIN ( 'test' ) {
   my @Test =
       { in =>  [ 1, 0, 5],  exp => 4,   },
       { in =>  [ 0, 2, 0],  exp => Int, },
       { in =>  [ 0, 3, 0],  exp => 2,   },
       { in =>  [ 0,],       exp => 0,   },
       { in =>  [ 1000,],    exp => 0,   },
       { in =>  [ 2,2],      exp => 0,   },
       { in =>  [2,2,2],     exp => 0,   },
       { in =>  [0,0,2,],    exp => Int, },
       { in =>  [3, 0, 3],   exp => 2,   },
       { in =>  [1,2,3,4,5], exp => '10',},
       { in =>  [1,2,8,4,5], exp => '10',},
       { in =>  [1,2,7,4,5], exp => Int, },
       { in =>  [11,1,1,1, 1,1,1,1,1, 1],  exp => '45', },
       { in =>  [ 1,1,1,1, 1,1,1,1,1,11],  exp => '45', },
       { in =>  [ 1,1,1,1,11,1,1,1,1, 1],  exp => '25', },
       { in =>  [ 6,1,1,1, 1,1,1,1,1, 6],  exp => '20', },
       { in =>  [ 5,1,1,1, 3,1, 1,1,1, 5], exp => '13', },
       { in =>  [ 1,1,1,3,1,10,1,1,1,1,1], exp => '26', },
       { in =>  [ 3,0,0,5,0,0,0,0,0,0,3,5,0,0,0,0,0,0,0,0,0,6], exp => '41', },
   ;

   plan +@Test;

   for @Test -> %t {
            my $e = Equalizer.new: people => @(%t<in>.Array);
            is $e.redistribution(), %t<exp>, "%t<in> --> %t<exp>.Int.raku()";
   }
   done-testing;
   exit;
}
