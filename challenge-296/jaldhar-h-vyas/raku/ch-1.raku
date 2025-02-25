#!/usr/bin/raku

multi sub MAIN(
    Str :$d!,  #= decode a run-length encoded string
) {
    say S:g/(\d+)(.)/$($1 x $0)/ given $d;
}

multi sub MAIN(
    Str :$e!    #= run-length encode a string
) {
    say S:g/((.)$0+)/$($0.chars)$0[0]/ given $e;
}
