#!/usr/bin/env raku
my @sur=1..50;
my $i=0;
@sur.splice($i=($i+1)%@sur,1)  while @sur > 1;
put "Survivor: @sur[]";

