#!/usr/bin/env raku

sub sequence-number (+@list) {
    @list.map: {
        .subst: rx/^<:L> ** 2/, ($++).fmt: "%02d"
    }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sequence-number('ab1234', 'cd5678', 'ef1342'),('001234', '015678', '021342');
    is sequence-number('pq1122', 'rs3334'),('001122', '013334');
    done-testing;
}

multi MAIN (+@list) {
    put sequence-number @list
}
