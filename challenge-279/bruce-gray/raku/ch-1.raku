sub task1 ( @letters, @weights --> Str ) {

    warn "Ambiguous"  if @weights.repeated;
    warn "Unexpected" if @weights.sort !eqv (@weights.keys X+ 1);
    warn "@letters is not the same size as @weights, but should be." if @letters !== @weights;

    return ( @weights Z @letters ).sort».[1].join;
}


use Test; plan +constant @tests =
    ( 'PERL'   , <R E P L>     , +«<3 2 1 4> ),
    ( 'RAKU'   , <A U R K>     , +«<2 4 1 3> ),
    ( 'PYTHON' , <O H Y N P T> , +«<5 4 2 6 1 3> ),
;
for @tests -> ( $expected, @letters, @weights ) {
    is task1(@letters, @weights), $expected, "@letters[], @weights[]";
}
