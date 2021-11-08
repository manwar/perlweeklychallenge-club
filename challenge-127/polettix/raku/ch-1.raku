#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @sequences = @args.map: *.split(/\D+/).Set;
   put ([(&)] @sequences) ?? 0 !! 1;
}
