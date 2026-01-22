#!/bin/env raku

unit sub MAIN(Any:D $int is copy where *.chars == 4);

my $cnt = 0;
while $int != 6174 {
    $int = $int.comb.sort.join;
    $int = ($int.flip - $int).fmt('%04d');
    if $int == 0 {
        put -1;
        exit;
    }
    ++$cnt;
}
put $cnt;
