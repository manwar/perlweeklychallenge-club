#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where 0 < * < 10 = 5) { put four-is-magic($n); }

sub four-is-magic (Int:D $n is copy where 0 < * < 10) {
   state @ints = <zero one two three four five six seven eight nine >;
   my $current = @ints[$n];
   my @seq = gather while $n != 4 {
      $n = $current.chars;
      my $next = @ints[$n];
      take "$current is $next";
      $current = $next;
   };
   @seq.push: 'four is magic.';
   @seq[0] = @seq[0].tclc;
   return @seq.join(', ');
}
