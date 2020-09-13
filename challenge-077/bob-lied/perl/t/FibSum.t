# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: FibSum.t
# DESCRIPTION: Unit test for FibSum
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use FibSum qw(_fib);

is( _fib( 0),         0, "f(0)");
is( _fib( 1),         1, "f(1)");
is( _fib( 2),         1, "f(2)");
is( _fib( 3),         2, "f(3)");
is( _fib( 4),         3, "f(4)");
is( _fib(10),        55, "f(10)");
is( _fib(20),      6765, "f(20)");
is( _fib(30),    832040, "f(30)");
is( _fib(40), 102334155, "f(40)");
is( _fib(93), 12200160415121876738, "f(93)");

my $fsum = FibSum->new(6);
isa_ok($fsum, [ "FibSum" ], "Constructor");

my $fibList = $fsum->getFibList();
is( $fibList, [ 5, 3, 2, 1 ], "fibList for 6" );
is( $fsum->target(), 6,       "target for 6" );

is( $fsum->run(), [ [ 5, 1], [ 3, 2, 1] ], "FibSum(6)" );

is( FibSum->new(9)->run(), [ [8, 1], [5, 3, 1] ], "FibSum(9)");



done_testing();
