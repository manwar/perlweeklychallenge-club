#!env raku

# Perl Weekly Challenge 57
# see <https://perlweeklychallenge.org/blog/perl-weekly-challenge-057/>
#
# Task 2


sub prefix( @words, $len ) {
    for @words.classify( *.substr( 0, $len ) ) {
        if $_.value.elems == 1 {
            say "Prefix { $_.key } (length = $len)";    
        }
        else {
            prefix( $_.value, $len + 1 );
        }
    }
}

sub MAIN( ) {
    my @words =  [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ];

    prefix( @words, 1 );

}
