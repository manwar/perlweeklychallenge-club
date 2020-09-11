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

use FibSum;

my $fsum = FibSum->new();
isa_ok($fsum, "FibSum", "Constructor");

done_testing();
