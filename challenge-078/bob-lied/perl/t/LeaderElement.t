# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: LeaderElement.t
# DESCRIPTION: Unit test for LeaderElement
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use lib "lib";
use LeaderElement;

my $t = LeaderElement->new();
isa_ok($t, [ "LeaderElement" ], "Constructor");

done_testing();
