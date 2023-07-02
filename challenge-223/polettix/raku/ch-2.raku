#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put box-coins(@args) }

sub box-coins ($box) {
   return 0 unless $box.elems;
   return $box[0] if $box.elems == 1;

   my @pre;
   my @post = @$box;
   return max gather while @post {
      my $item = @post.shift;
      take samewith([|@pre, |@post])
         + (@pre ?? @pre[*-1] !! 1) * $item * (@post ?? @post[0] !! 1);
      @pre.push: $item;
   }
}
