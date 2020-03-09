#!/usr/bin/env raku
#noble integer
my $size=@*ARGS[0]//3;
my @list=(50.rand.Int+1 xx $size).sort;
put "Sorted input list: @list[]";
put "Noble Integers found: ",@list[(^@list).grep({(@list-$_-1) == @list[$_]})];
