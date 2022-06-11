#!raku
# Perl Weekly Challenge 160

sub MAIN( *@A where { @A.grep( * ~~ Int ).elems == @A.elems } ) {
    for 1 ..^ @A.elems {
        .say and exit if @A[ 0 .. $_ - 1 ].sum == @A[ $_ .. * - 1 ].sum;
    }
    '-1'.say;

}
