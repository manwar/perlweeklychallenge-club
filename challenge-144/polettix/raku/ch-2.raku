#!/usr/bin/env raku
use v6;

class Ulam {
   has @!items is built;
   has $!n = 0;

   method new ($v, $w) { self.bless(items => [$v, $w]) }

   method next () {
      ITEM:
      while $!n > @!items.end {
         @!items.push: (@!items X @!items).grep({ $_[0] < $_[1] })
            .map({$_.sum}).grep({$_ > @!items[*-1]})
            .Bag.pairs.grep({.value == 1}).map({.key}).min;
      }
      return @!items[$!n++];
   }
}

sub MAIN (*@args) {
   my ($v, $w) = @args.elems == 2 ?? @args !! (1, 2);
   my $ulam = Ulam.new($v, $w);
   (1..10).map({$ulam.next}).join(', ').put;
}
