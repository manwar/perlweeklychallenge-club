use strict; use warnings; use Test::More tests => 2;

sub dest {
    my %further = map { $$_[0] => 1 } @_;
    grep !$further{$_}, map $$_[1], @_;
}

is_deeply [ dest( ["B","C"], ["D","B"], ["C","A"] ) ] => [ 'A' ];
is_deeply [ dest( ["A","Z"] ) ]                       => [ 'Z' ];
