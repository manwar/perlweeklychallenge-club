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
isa_ok($lx, "LonelyX", "Constructor");

$lx->loadGrid("t/example1.txt");
is($lx->{_lastRow}, 2, "loadGrid rows");
is($lx->{_lastCol}, 2, "loadGrid cols");

done_testing();
