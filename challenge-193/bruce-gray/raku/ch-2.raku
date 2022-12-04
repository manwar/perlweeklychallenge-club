sub oddballs ( @list, &matcher ) {
    my %h = @list
            .classify(&matcher)
            .values
            .classify({ .elems == 1 ?? 'Oddball' !! 'Clique' });

    warn "Multiple cliques exist" if %h<Clique>.elems > 1;

    return %h<Oddball>.list;
}
sub neighbor_distances ( Str $s --> Str ) {
    return $s.comb
             .map(&ord)
             .rotor(2 => -1)
             .map({ .[1] - .[0] })
             .Str;
}
sub task2 (@list) {
    die "Must have at least 3 to have an oddball" if @list.elems < 3;

    my @o = oddballs( @list, &neighbor_distances );

    warn "No oddballs found"     if not @o;
    warn "More than one oddball" if @o.elems > 1;

    return @o.head;
}


constant @tests =
    ( 'abc', <adc wzy abc    > ),
    ( 'bob', <aaa bob ccc ddd> ),

    # ( 'aaz', <aaa bbb ccc ddd aaz aay> ), # More than one oddball;
    # ( 'aaz', <aaa bbb ccd dde aaz    > ), # More than one clique;
;
use Test;
plan +@tests;
for @tests -> ( $expected, @input ) {
    is task2(@input), $expected;
}
