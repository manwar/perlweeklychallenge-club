#!/usr/bin/env raku

use experimental :cached;
use Test;
plan 21;

my @results = <
#
2#
#3#
2#4#
#3#5#
2#4#6#
#3#5#7#
2#4#6#8#
#3#5#7#9#
#3#5#7#10#
2#4#6#8#11#
#3#5#7#9#12#
#3#5#7#10#13#
2#4#6#8#11#14#
#3#5#7#9#12#15#
#3#5#7#10#13#16#
2#4#6#8#11#14#17#
#3#5#7#9#12#15#18#
#3#5#7#10#13#16#19#
2#4#6#8#11#14#17#20#
#3#5#7#9#12#15#18#21#
>;

for 1..21 
{
    is hash-string($_), @results[$_-1];
}

sub hash-string(UInt $n where $n > 0) is cached
{
    given $n 
    {
        when 1  { "#"                                        }
        when 2  { "2#"                                       }
        when 3  { "#3#"                                      }
        default { hash-string($n - $n.chars - 1) ~ $n ~ "#"  }
    }
}    
