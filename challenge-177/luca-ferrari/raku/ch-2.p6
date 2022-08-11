#!raku

# Perl Weekly Challenge 177

sub MAIN( int $limit = 20 ) {

    my @cyclops = lazy gather {
        for 100 .. Inf {
            # skip numbers that have not an odd count of digits
            next if $_.Str.chars %% 2;

            # skip if the number does not have a middle zero
            next if $_.comb[ ( $_.Str.chars / 2 ).Int ] != 0;

            # skip if it is not palindrome
            next if $_.Str != $_.Str.flip;

            take $_;
        }
    };

    @cyclops[ 0 .. $limit ].join( "\n" ).say;

}
