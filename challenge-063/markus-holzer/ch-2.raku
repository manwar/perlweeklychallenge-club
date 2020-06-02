multi sub rotmodN( Str $orig ) 
{ 
    rotmodN $orig.comb.List
}

multi sub rotmodN ( List $orig, $n = $orig.elems ) 
{ 
    my $work = $orig;

    for ( 1 .. Inf ).map( * % $n ).kv -> $i, $by
    {
        $work = $work.rotate: $by;

        return $i + 1 
            if $work cmp $orig == Same
    }
}

say rotmodN 'xyxx'