use strict; use warnings; use Test::More tests=>5;

sub once {
    my %freq;
    $freq{$_}++ for @_;
    $freq{$_}==1 and return $_ for @_;
    undef
}

is once( 3, 3, 1          ) => 1;
is once( 3, 2, 4, 2, 4    ) => 3;
is once( 1                ) => 1;
is once( 4, 3, 1, 1, 1, 4 ) => 3;
is once( (1..9) x 2       ) => undef;
