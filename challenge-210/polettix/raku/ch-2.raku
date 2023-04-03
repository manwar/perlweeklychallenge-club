#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put '(', number-collision(@args).join(', '), ')' }

sub number-collision (@list is copy) {
   my (@pre, @post); # safe items on the left and on the right

   loop {
      @pre.push:     @list.shift while @list && @list[0] < 0;
      @post.unshift: @list.pop   while @list && @list[*-1] > 0;
      last if @list == 0;

      my @mid;
      INDEX:
      for ^@list -> $i {
         my $item = @list[$i];
         if $item > 0 { # try to move right
            @mid.push: $item if $item + @list[$i + 1] > 0;
         }
         elsif $item < 0 { # try to move left
            @mid.push: $item if $item + @list[$i - 1] < 0;
         }
         else { # try to stay put
            my $safe-left  = ($i == 0) || (@list[$i - 1] <= 0);
            my $safe-right = ($i == @list.end) || (@list[$i + 1] >= 0);
            @mid.push: 0 if $safe-left && $safe-right;
         }
      }

      # stop simulation if nothing changed in this pass
      last if @list.elems == @mid.elems;

      # go to next iteration with surviving items in the middle
      @list = @mid;
   }

   return (@pre, @list, @post).flat.Array;
}
