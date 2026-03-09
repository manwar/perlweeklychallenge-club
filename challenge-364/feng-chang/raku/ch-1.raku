#!/bin/env raku

unit sub MAIN(Str:D $s);

my regex rgx { ^ [ (\d) || (\d\d) '#' ]* $ };
my %hchars = 1..26 Z=> 'a'..'z';

put %hchars{ $s.match(/<rgx>/).<rgx>».Str[0].Array }.join;
