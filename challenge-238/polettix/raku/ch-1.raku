#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { say running-sum-alternative2(@args) }

sub running-sum (@int) {
   my $accumulator = 0;
   return [ @int.map({$accumulator += $_}) ];
}

sub running-sum-alternative (@int) {
   return [ gather { take @int[0]; @int.reduce({ take $^a + $^b }) } ]
}

sub running-sum-alternative2 (@int) { @int.produce(&[+]) }
