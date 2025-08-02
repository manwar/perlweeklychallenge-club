use List::Util 'sum'; use Test::More tests => 3; use feature 'signatures'; no warnings 'experimental';

sub GDS($s,$i) { length $s <= $i ? $s : GDS( join( '', map sum(/./g), $s =~ /.{,$i}/g ), $i ) }

is GDS( $$test{str}, $$test{int}), $$test{output} for
    { str => "111122333",    int => 3, output => "359"},
    { str => "1222312",      int => 2, output => "76"},
    { str => "100012121001", int => 4, output => "162"};
