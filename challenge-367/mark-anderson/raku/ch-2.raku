#!/usr/bin/env raku
use Test;

ok  conflict-events(<10:00 12:00>, <11:00 13:00>);
nok conflict-events(<09:00 10:30>, <10:30 12:00>);
ok  conflict-events(<14:00 15:30>, <14:30 16:00>);
nok conflict-events(<08:00 09:00>, <09:01 10:00>); 
ok  conflict-events(<23:30 00:30>, <00:00 01:00>);

sub conflict-events(@a,@b)
{
    :(@a,@b) := sort (@a,@b); # if event 2 starts first. 
    return False  if (@a,@b).flat.antipairs.sort>>.values.flat ~~ any <0 1 2 3>,
                                                                      <3 0 1 2>;
    return True
}
