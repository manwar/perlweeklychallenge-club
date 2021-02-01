#!raku


sub MAIN( ) {
    my @N = 1,2,3,4, 7;
    my $N = 6;
    say "Array { @N } searching for $N";

    # get the index if the element is there
    given @N.grep: $N, :k { .say && exit if $_ }

    # if here the element is not there
    # for @N.List.kv -> $k, $v {
    #     if ( $v > $N ) {
    #         @N = |@N[ 0 .. $k - 1 ], $N, |@N[ $k .. * ];
    #         "Insert value $N at index $k".say;
    #     }
    # }


    given @N.grep: { $_ > $N }, :k {
        @N = |@N[ 0 .. $_ - 1 ], $N, |@N[ $_ .. * ];
        "Insert value $N at index $_".say;
        exit;
    }

}
