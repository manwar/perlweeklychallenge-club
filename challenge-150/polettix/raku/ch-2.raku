#!/usr/bin/env raku
use v6;

multi sub MAIN (Int $limit = 500) {
   my @list = (1 .. $limit).grep({is-square-free($_)});
   while @list {
      @list.splice(0, 20).join(', ').print;
      put @list ?? ',' !! '';
   }
}

multi sub MAIN (*@args) {
   put $_, ' ', (is-square-free($_) ?? 'is' !! 'is not'), ' square free'
      for @args;
}

sub is-square-free ($N is copy) {
   return False if $N %% 4;
   my $divisor = 3;
   while $N > $divisor {
      if $N %% $divisor {
         $N = ($N / $divisor).Int;
         return False if $N %% $divisor;
      }
      $divisor += 2; # go through odd candidates only
   }
   return True;
}
