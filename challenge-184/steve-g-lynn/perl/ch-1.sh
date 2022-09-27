#!/bin/sh

perl -e 'my $ctr=0; for my $x ("00" .. "99") {print $x . substr($ARGV[$ctr++],2,4) . " "; last if $ctr >= @ARGV;} print "\n";' 'ab1234' 'cd5678' 'ef1342'

#001234 015678 021342

#perl -e 'my $ctr=0; for my $x ("00" .. "99") {print $x . substr($ARGV[$ctr++],2,4) . " "; last if $ctr >= @ARGV;} print "\n";' 'pq1122' 'rs3334'

#001122 013334
