# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: LeftRotation.t
# DESCRIPTION: Unit test for LeftRotation
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use lib "lib";
use LeftRotation;

my $t = LeftRotation->new();
isa_ok($t, [ "LeftRotation" ], "Constructor");

done_testing();
