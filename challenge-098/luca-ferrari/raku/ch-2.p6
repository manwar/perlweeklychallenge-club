#!raku

# Get an array of integers, the last value is the need to search for
# while all the other values are the array to search into.
# For example:
# ch-2.p6 1 2 3 7 8 9 5
# means
# @N = 1,2,3,7,8,9
# $N = 5
sub MAIN( *@values where { @values.grep: * ~~ Int } ) {
    my @N = @values[0 .. *-2 ];
    my $N = @values[ *-1 ];
#    say "Array { @N } searching for $N";

    # get the index if the element is there
    given @N.grep( $N, :k ).first { .say && exit if $_ }

    # if here the key is not there, let's see where to insert
    given @N.grep( { $_ >= $N }, :k ).first {
        @N = |@N[ 0 .. $_ - 1 ], $N, |@N[ $_ .. * ];
        .say && exit;
    }

}
