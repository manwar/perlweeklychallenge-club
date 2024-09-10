use strict; use warnings; use List::Util qw(min max); use Test::More tests=>3;

sub order_game {
    @_==1 ? pop : order_game( map [\&max,\&min]->[ $_ & 1 ]->( shift, shift ), 1 .. @_/2 )
}

is order_game(2,1,4,5,6,3,0,2)                 => 1;
is order_game(0,5,3,2)                         => 0;
is order_game(9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8) => 2;
