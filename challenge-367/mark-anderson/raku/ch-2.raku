#!/usr/bin/env raku
use Test;

=begin assumptions

Assumptions:

1: The second event does not start before the first.
   
   Something like the following would be true if event 1 starts first 
   but it would be false if event 2 starts first.

   conflict-events(<22:01 11:00>, <10:59 22:00>);

2: The duration of each event is >= 1 minute.

   Not sure how to handle something like this:

   conflict-events(<22:00 22:00>, <22:00 22:30>);
   
=end assumptions

ok  conflict-events(<10:00 12:00>, <11:00 13:00>), 1;
nok conflict-events(<09:00 10:30>, <10:30 12:00>), "default";
ok  conflict-events(<14:00 15:30>, <14:30 16:00>), 1;
nok conflict-events(<08:00 09:00>, <09:01 10:00>), "default";
ok  conflict-events(<23:30 00:30>, <00:00 01:00>), 2;

# More tests
ok  conflict-events(<12:00 14:00>, <12:00 12:30>), 1;
ok  conflict-events(<12:00 14:00>, <13:00 14:00>), 1;
ok  conflict-events(<12:00 14:00>, <12:30 13:30>), 1;
ok  conflict-events(<00:00 00:55>, <00:05 00:59>), 1;
ok  conflict-events(<15:00 12:00>, <08:00 16:00>), 2;
ok  conflict-events(<15:00 12:00>, <11:00 12:00>), 2;
ok  conflict-events(<22:01 11:00>, <10:59 22:00>), 2;
ok  conflict-events(<23:30 00:30>, <23:45 01:00>), "3T";
ok  conflict-events(<15:00 03:00>, <22:00 12:00>), "3T";
nok conflict-events(<23:57 00:02>, <22:02 23:58>), "3F";
nok conflict-events(<15:00 12:00>, <12:01 12:04>), "3F";
nok conflict-events(<00:00 01:00>, <23:30 00:30>), "default";
nok conflict-events(<22:00 10:00>, <10:00 22:00>), "default";
nok conflict-events(<10:59 22:00>, <22:01 11:00>), "default";
# (More tests are probably needed)

sub conflict-events(@a,@b)
{
    given (@a, @b).flat
    {
        when .[0] lt .[1] gt .[2] { return True  } # 1
        when .[0] gt .[1] gt .[2] { return True  } # 2
        when .[0] gt .[1] lt .[2] 
        {    
            when .[0] lt .[2]     { return True  } # 3T or 3F
        }                                          
        default                   { return False } # default
    }
}
