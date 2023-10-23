#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { say persistence-sort(@args) }

sub persistence-sort (@int) {
   return @int
      .map({ [$_, persistence-for($_)] })
      .sort({ ($^a[1] <=> $^b[1]) || ($^a[0] <=> $^b[0]) })
      .map({ $_[0] })
      .Array;
}

sub persistence-for ($v) {
   my $rounds = 0;
   my @digits = $v.comb;
   while @digits > 1 {
      ++$rounds;
      @digits = ([*] @digits).comb;
   }
   return $rounds;
}
