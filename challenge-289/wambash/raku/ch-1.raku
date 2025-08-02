#!/usr/bin/env raku

proto n-maximum(@ints, :$k) {*}

multi n-maximum( @ints, :$k where { @ints.elems < $k } = 3 ) {
    @ints.max
}

multi n-maximum( @ints, :$k=3 ) {
    my %msl{Order} = More, [], Less, [], Same, [];
    my $pivot = @ints.roll;

    with @ints.classify: { $_ cmp $pivot }, :into(%msl) -> %g {
        my %e = %g.nodemap: *.elems;
        when %e{More} ≥ $k          { samewith %g{More}, :$k }
        when %e{More,Same}.sum ≥ $k { $pivot }
        default                     { samewith %g{Less}, k => $k - %e{More,Same}.sum }
    }
}

sub n-maximum-unique(@ints, :$k=3) {
    n-maximum @ints.unique, :$k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is n-maximum((4,4,4,4,5)), 4;
    is n-maximum-unique((4,4,4,4,5)), 5;
    is n-maximum((1,2,2,3)), 2;
    is n-maximum-unique((1,2,2,3)), 1;
    is n-maximum((5,6,4,1)), 4;
    is n-maximum(^2_000 .pick(*),:20k), 1980;
    done-testing;
}

multi MAIN ( +ints, :$k=3 ) {
    say n-maximum-unique ints, :$k
}
