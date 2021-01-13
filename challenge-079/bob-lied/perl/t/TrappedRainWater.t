# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: TrappedRainWater.t
# DESCRIPTION: Unit test for TrappedRainWater
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;
use TrappedRainWater;

my $trw = TrappedRainWater->new(2, 1, 4, 1, 2, 5);

isa_ok( $trw, [ qw(TrappedRainWater) ], "Constructor" );

done_testing();
