# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#===============================================================================
# FILE: MajorityElement.t
#===============================================================================

use strict;
use warnings;

use Test2::V0;

use MajorityElement;

is( majorityElement(1,2,2,3,2,4,2),  2, "Example 1");
is( majorityElement(1,3,1,2,4,5),   -1, "Example 2");

is( majorityElement(1),              1, "Single element");

done_testing();
