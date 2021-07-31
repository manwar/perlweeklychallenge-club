sub is-square ( @p where *.elems == 4 ) {
    my %xy = @p.categorize( <x y> Z~ *.list );

    return @p.map(*.Str).unique == 4
        && so %xy.values.all    == 2;
}

my @tests =
    ( 'SampleA'   , True  , ((10,20),(20,20),(20,10),(10,10)) ),
    ( 'SampleB'   , False , ((12,24),(16,10),(20,12),(18,16)) ),
    ( 'NotUnique' , False , ((10,20),(20,10),(10,20),(20,10)) ),
;
use Test;
plan +@tests;
for @tests -> ( $name, $expected, @input ) {
    is is-square(@input), $expected, $name;
}
