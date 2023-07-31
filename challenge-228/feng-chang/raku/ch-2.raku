#!/bin/env raku

unit sub MAIN(*@N);

my $cnt = 0;

while @N {
    my $ndx = @N.first(@N.min, :k);
    $cnt += $ndx + 1;
    @N.splice($ndx, 1);
}

put $cnt;
