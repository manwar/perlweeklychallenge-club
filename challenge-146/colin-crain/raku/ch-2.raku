#!/usr/bin/env perl6
#
#
#       curiously-arboreal.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Str $input = "9/13" ) ;




$input ~~ m{ (\d+) \/ (\d+) };
my ($num, $den) = $0, $1;
say "input       is $num/$den";

my @parent = get_parent( $num, $den);
say "parent      is ", @parent.join: '/';
say "grandparent is ", (get_parent( |@parent )).join: '/',;



sub get_parent ( $num, $den ) {
    return ( $num < $den ) 
        ?? ( $num, $den - $num )     ## left child
        !! ( $num - $den, $den ) ;   ## right child
}

