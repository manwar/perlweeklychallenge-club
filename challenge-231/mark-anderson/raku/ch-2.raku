#!/usr/bin/env raku
use Test;

is senior-citizens(<7868190130M7522 5303914400F9211 9273338290F4010>), 2;
is senior-citizens(<1313579440F2036 2921522980M5644>),                 0; 
is senior-citizens(<9273338291M1023>),                                 1;

sub senior-citizens(*@a)
{
    @a.match(/ <[FM]> [ <[6789]> \d || 1\d\d ] /, :g).elems
}
