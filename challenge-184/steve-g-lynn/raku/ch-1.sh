#!/bin/sh

raku -e 'my $ctr=0; for ("00" .. "99") -> $x {print $x ~ @*ARGS[$ctr++].substr(2,4) ~ " "; last if $ctr >= @*ARGS }; print "\n";' 'ab1234' 'cd5678' 'ef1342'

#001234 015678 021342

#raku -e 'my $ctr=0; for ("00" .. "99") -> $x {print $x ~ @*ARGS[$ctr++].substr(2,4) ~ " "; last if $ctr >= @*ARGS }; print "\n";' 'pq1122' 'rs3334'

#001122 013334
