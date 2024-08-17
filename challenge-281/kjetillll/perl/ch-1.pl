use strict; use warnings; use Test::More tests=>2;

sub is_light { pop() =~ /^( [aceg][2468] | [bdfh][1357] )$/x }

ok is_light( "d3" ) == 1;
ok is_light( "g5" ) == 0;
