#!/usr/bin/env raku
use v6;
sub consecutive-arrays (*@args) {
   return unless @args;
   my $previous = @args[0];
   my @retval;
   for @args -> $n {
      @retval.push: [] if $n != $previous + 1;
      @retval[*-1].push: $n;
      $previous = $n;
   }
   return @retval.List;
}
sub MAIN (*@args) {
   @args = 1, 2, 3, 6, 7, 8, 9 unless @args;
   consecutive-arrays(@args).say;
}
