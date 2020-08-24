# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#===============================================================================
# FILE: FNR.t
#===============================================================================

use strict;
use warnings;

use Test2::V0;

use FNR;

is( firstNonRepeat('ababc'),
                   'abb#c',    "Example 1");
is( firstNonRepeat('xyzzyx'),
                   'xyzyx#', "Example 2 as given");
#is( firstNonRepeat('xyzzyx'),
#                   'xxxxx#', "Example 2 as specified");

done_testing();
