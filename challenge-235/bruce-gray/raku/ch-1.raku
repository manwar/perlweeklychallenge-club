sub task1-multi-pass ( @ns --> Bool ) {
    return False if [<] @ns;

    sub good_without ( UInt $i ) { [<] all_except($i) }

    sub all_except   ( UInt $i ) { |@ns.head($i),
                                   |@ns.skip($i + 1) }

    return @ns.keys
              .first( &good_without )
              .defined;
}

sub task1-single-pass ( @ns --> Bool ) {
    return False if @ns.elems == 0;
    return True  if @ns.elems == 1|2;

    my ($bad_spot, @rest) = @ns.rotor( 2 => -1 ).grep( :k, { .[0] !< .[1] } );

    return True  if $bad_spot.defined.not;
    return False if @rest;
    
    return True if $bad_spot   == 0
                or $bad_spot+1 == @ns.end;

    return [<] @ns[$bad_spot-1, $bad_spot+1];
}


my @tests =
    ( (0, 2, 9, 4, 6) , True  ),
    ( (5, 1, 3, 2)    , False ),
    ( (2, 2, 3)       , True  ),
;
use Test; plan 2*@tests;
for @tests -> ( @in , $expected ) {
    is task1-multi-pass( @in), $expected;
    is task1-single-pass(@in), $expected;
}
