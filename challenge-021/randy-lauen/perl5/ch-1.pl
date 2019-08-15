#!/usr/bin/env perl

use 5.020;
use strict;
use warnings;

use Math::Big ();
use Math::NumberCruncher ();
use Math::Pari ();
use Math::Symbolic ();
use Math::AnyNum ();
use Sidef ();
use Text::Table::Tiny ();

my @eulers = (
    [ 'Math::Big::euler',              sub { Math::Big::euler(1, 47) } ],
    [ 'Math::NumberCruncher::ECONST',  sub { Math::NumberCruncher::ECONST( 46 ) } ],
    [ 'Math::Symbolic::EULER',         sub { Math::Symbolic::EULER } ],
    [ 'Math::AnyNum::euler',           sub { Math::AnyNum->e } ],
    [ 'Sidef',                         sub { Sidef->new()->execute_code("Number.e()") } ],
    # [ 'Math::Pari::Euler', sub { Math::Pari::Euler() } ],  NOPE! Euler's constant is not the same as Euler's number!
);

my @table = [ 'Module', q{Euler's Number} ];
foreach my $euler ( @eulers ) {
    push @table, [ $euler->[0], $euler->[1]->() ];
}

say Text::Table::Tiny::generate_table( header_row => 1, rows => \@table );

exit 0;

