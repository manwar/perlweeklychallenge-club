#!/use/bin/env perl6
use v6;

subset FilePath of Str where *.IO.f;

#| Given a dictionary of words to check and a list of available letters
#| Print the words that can be made using just those letters
sub MAIN (
    FilePath $dict, #= Dictionary file to read
    *@letters #= List of letters allowed to be used 
) {
    my $check-set = bag( @letters.map( *.lc ) );

    $dict.IO.words.race.grep( { bag( $_.lc.comb ) (<=) $check-set } )>>.say;
}

