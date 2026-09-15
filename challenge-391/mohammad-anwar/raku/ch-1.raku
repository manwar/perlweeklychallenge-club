#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [[2],[4]],               out => 3.0  },
    { in => [[1,2,3],[7,8,9,10]],    out => 7.0  },
    { in => [[],[10,20,30,40]],      out => 25.0 },
    { in => [[100],[1,2,3,4,5,6,7]], out => 4.5  },
    { in => [[1,2,2],[2,2,3]],       out => 2.0  },
);

for @examples -> %ex {
    is median(%ex<in>), %ex<out>;
}

done-testing;

sub median(@in) {
    my @m   = @in.map(*.Slip).flat.sort;
    my $mid = @m.elems div 2;
    return @m.elems % 2 ?? @m[$mid] !! (@m[$mid - 1] + @m[$mid]) / 2;
}
