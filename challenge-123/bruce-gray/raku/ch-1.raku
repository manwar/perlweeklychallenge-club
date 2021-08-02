sub is-square ( @p where *.elems == 4 ) {
    my %xy = @p.categorize( <x y> Z~ *.list );

    my ($left-side, $bottom-side) = .[2][0] - .[0][0],
                                    .[1][1] - .[0][1] given @p.sort;

    return $bottom-side         == $left-side
        && @p.map(*.Str).unique == 4
        && so %xy.values.all    == 2;
}

my @tests =
    ( 'SampleA'   , True  , ((10,20),(20,20),(20,10),(10,10)) ),
    ( 'SampleB'   , False , ((12,24),(16,10),(20,12),(18,16)) ),
    ( 'NotUnique' , False , ((10,20),(20,10),(10,20),(20,10)) ),
    ( 'Rectangle' , False , ((10,10),(90,10),(90,20),(10,20)) ),
;
use Test;
plan +@tests;
for @tests -> ( $name, $expected, @input ) {
    is is-square(@input), $expected, $name;
}
