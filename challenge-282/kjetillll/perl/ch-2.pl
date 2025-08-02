use strict; use warnings; use Test::More tests=>3;

sub f {
    my($str, $count) = (@_,0);
    $str =~ s/(.)(.)/$2/ ? f($str,$count + (uc$1 ne uc$2)) : $count
}

is f('pPeERrLl') => 3;
is f('rRr') => 0;
is f('GoO') => 1;
