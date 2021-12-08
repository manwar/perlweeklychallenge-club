#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   await @args.map: -> $x { Promise.in($x).then({$x.put}) }
}
