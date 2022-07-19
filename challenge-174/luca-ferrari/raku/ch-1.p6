#!raku

# Perl Weekly Challenge 174

sub MAIN( Int $limit = 19 ) {

    my @disarium-numbers = lazy gather {
        for 10 .. Inf {
            my $index = 0;
            take $_ if $_.comb.map( * ** ++$index ).sum == $_;
        }
    };

    @disarium-numbers[ 0 .. $limit ].join( "\n" ).say;
}
