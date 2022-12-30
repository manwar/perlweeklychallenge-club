#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   @args = <1 0 3 0 0 5>».Int unless @args;
   put '(', move-zero-in-place(@args).join(', '), ')';
}

sub move-zero-in-place (@list) {
   my $i = 0;
   my $n-zeros = 0;
   while $i < @list {
      if @list[$i] == 0 {
         ++$n-zeros;
         @list.splice($i, 1);
      }
      else { ++$i }
   }
   @list.push: |(0 xx $n-zeros);
   return @list;
}
