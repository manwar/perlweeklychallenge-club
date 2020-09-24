# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: CountSetBit.t
# DESCRIPTION: Unit test for CountSetBit
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;
use CountSetBit;

my $csb = CountSetBit->new(4);
isa_ok( $csb, [ qw(CountSetBit) ], "Constructor" );

is( CountSetBit->new( 1)->run(),   1, "1");
is( CountSetBit->new( 2)->run(),   2, "2");
is( CountSetBit->new( 3)->run(),   4, "3");
is( CountSetBit->new( 4)->run(),   5, "4");
is( CountSetBit->new( 5)->run(),   7, "5");
is( CountSetBit->new( 6)->run(),   9, "6");
is( CountSetBit->new( 7)->run(),  12, "7");
is( CountSetBit->new( 8)->run(),  13, "8");
is( CountSetBit->new( 9)->run(),  15, "8");
is( CountSetBit->new(10)->run(),  17, "8");
is( CountSetBit->new(11)->run(),  20, "8");
is( CountSetBit->new(12)->run(),  22, "8");
is( CountSetBit->new(13)->run(),  25, "8");
is( CountSetBit->new(14)->run(),  28, "8");
is( CountSetBit->new(15)->run(),  32, "8");
is( CountSetBit->new(16)->run(),  33, "8");

done_testing();
