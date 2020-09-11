# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: LonelyX.t
# DESCRIPTION: Unit test for LonelyX
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use LonelyX;

my $lx = LonelyX->new();
isa_ok($ls, "LonelyX", "Constructor");

done_testing();
