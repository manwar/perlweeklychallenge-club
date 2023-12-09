#!/usr/bin/env raku

sub out-of ($n=6,$f=48) {
   1..$f
   andthen .pick: $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is out-of().elems,6;
    is 1 ≤ out-of().all ≤ 49, True;
    done-testing;
}

multi MAIN ($n=6,$f=48) {
    put out-of $n,$f
}
