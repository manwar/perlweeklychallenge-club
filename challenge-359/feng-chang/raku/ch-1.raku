#!/bin/env raku

unit sub MAIN(UInt:D $int is copy);

my $persistence = 0;
while $int.chars > 1 {
    $int = $int.comb.sum;
    ++$persistence;
}

print qq:to/END/;
    Persistance  = $persistence
    Digital Root = $int
    END
