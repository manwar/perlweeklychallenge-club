#!/usr/bin/env raku
use v6;
sub MAIN {
   my @l = < ab1234 cd5678 ef1342 >;
   sequence-number(@l);
   .put for @l;
}

sub sequence-number (@list) {
   my $n = 0;
   @list.map({.substr-rw(0, 2) = '%02d'.sprintf($n++)});
   @list;
}
