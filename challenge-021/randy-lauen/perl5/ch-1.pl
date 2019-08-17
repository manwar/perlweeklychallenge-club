#!/usr/bin/env perl

use 5.020;
use strict;
use warnings;

# Write a script to calculate the value of e, also known as Euler’s number and Napier’s constant.

# Instead of implementing it myself, I took a tour through
# some of the CPAN modules that do it for you.

use Math::Big ();
use Math::NumberCruncher ();
use Math::Symbolic ();
use Math::AnyNum ();
use Sidef ();
use Text::Table::Tiny ();

my @eulers = (
    [ 'Math::Big::euler',              sub { Math::Big::euler(1, 47) } ],
    [ 'Math::NumberCruncher::ECONST',  sub { Math::NumberCruncher::ECONST( 46 ) } ],
    [ 'Math::NumberCruncher::_e_',     sub { substr( $Math::NumberCruncher::_e_, 0, 48 ) . '...' } ],
    [ 'Math::Symbolic::EULER',         sub { Math::Symbolic::EULER } ],
    [ 'Math::AnyNum::euler',           sub { Math::AnyNum->e } ],
    [ 'Sidef Number.e',                sub { Sidef->new()->execute_code("Number.e()") } ],
    [ 'bigrat::e',                     sub { require bigrat; bigrat::e() } ],
);

my @table = [ 'Module', q{Euler's Number} ];
foreach my $euler ( @eulers ) {
    push @table, [ $euler->[0], $euler->[1]->() ];
}

say Text::Table::Tiny::generate_table( header_row => 1, rows => \@table );

