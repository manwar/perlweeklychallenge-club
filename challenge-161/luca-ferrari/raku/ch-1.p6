#!raku
# Perl Weekly Challenge 161


sub MAIN( Str $dictionary-file-name? = '../../data/dictionary.txt' ) {
    die "\nCannot find the dictionary [$dictionary-file-name]\n" if ! $dictionary-file-name || ! $dictionary-file-name.IO.f;

    # store the length and the list (array) of words for such length
    my %abecedarian-words;

    for $dictionary-file-name.IO.lines -> $word {
        # a word is abecedarian if the sorted letter composed word
        # is equal to the word itself
        %abecedarian-words{ $word.chars }.push: $word if ( $word.comb.sort.join ~~ $word );
    }

    # print the length and the list of words
    "( $_ ):\n { %abecedarian-words{ $_ }.join( ',' ) }".say for %abecedarian-words.keys.sort;

}
