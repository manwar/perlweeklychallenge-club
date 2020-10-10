# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: SmallestPositive.t
# DESCRIPTION: Unit test for SmallestPositive
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use SmallestPositive;

my $sp = SmallestPositive->new( 5, 2, -2, 0 );
isa_ok($sp, [ qw(SmallestPositive) ], "Constructor" );
is( $sp->{_N}, [ 2,5 ],               "Initialization" );

is( SmallestPositive->new(-2)->run(),            1, "Empty list" );
is( SmallestPositive->new(-2, 1)->run(),         2, "list=(1)" );
is( SmallestPositive->new(-2, 2)->run(),         1, "list=(2)" );
is( SmallestPositive->new(5, 2, -2, 0)->run(),   1, "list=(5)" );
is( SmallestPositive->new(1, 8, -1)->run(),      2, "list=(8)" );
is( SmallestPositive->new(1, 2, 3)->run(),       4, "sequence" );
is( SmallestPositive->new(10, 20, 30)->run(),    1, "holes" );
is( SmallestPositive->new( (1..50), 52)->run(), 51, "list(50)" );
is( SmallestPositive->new( (-7..-1) )->run(),    1, "negative" );

done_testing();
