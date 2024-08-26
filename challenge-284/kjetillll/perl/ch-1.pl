use strict; use warnings; use List::Util 'max'; use Test::More tests=>3;


sub lucky_integer {
    my %freq; $freq{$_}++ for @_;
    max -1, grep $_ == $freq{$_}, keys %freq
}


is lucky_integer(2, 2, 3, 4)       => 2;
is lucky_integer(1, 2, 2, 3, 3, 3) => 3;
is lucky_integer(1, 1, 1, 3)       => -1;
    
