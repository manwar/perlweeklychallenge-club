#!/usr/bin/env raku
use v6;
sub MAIN (Int $n where * > 0 = 5) {
   class PennyPilesIterator { ... }
   my $it = PennyPilesIterator.new($n);
   while defined(my $seq = $it.next) {
      $seq.say
   }
   put $it.count;
}

class PennyPilesIterator {
   has @!trail is built;
   has @!stack is built;
   has $.count = 0;

   method new ($n) { self.bless(trail => [], stack => [$n]) }

   method next () {
      my $retval = Nil;
      while (@!stack && ! $retval) {
         if @!stack[*-1] == 0 {
            $retval = [ |@!trail ];
            ++$!count;
         }
         if (@!trail < @!stack) { # initialize
            my $min = @!trail ?? @!trail[*-1] !! 1;
            @!trail.push: $min;
         }
         else { # continue this frame's iteration
            @!trail[*-1]++;
         }
         if (@!trail[*-1] <= @!stack[*-1]) { # "recurse"
            @!stack.push: @!stack[*-1] - @!trail[*-1];
         }
         else { # "return"
            @!trail.pop;
            @!stack.pop;
         }
      }
      return $retval;
   }
}
