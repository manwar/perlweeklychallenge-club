#!/usr/bin/env raku

my @H = (2, 6, 4, 5, 1, 3);
my @T = (1, 0, 2, 0, 1, 2);
my @Q;
@Q.splice: .value, 0, .key for (@H Z=> @T).sort: -*.key;
print @Q;
