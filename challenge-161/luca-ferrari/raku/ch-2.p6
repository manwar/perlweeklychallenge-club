#!raku
# Perl Weekly Challenge 161


sub MAIN( Str $dictionary? = '../../data/dictionary.txt' ){
    die "\nCannot find dictionary [$dictionary]" if ( ! $dictionary || ! $dictionary.IO.f );

    # read all the words in alphabetical order
    my @words = $dictionary.IO.lines.sort;


    my @letters =  'a' .. 'z' ;
    my @found;

    for @letters {
        # avoid to search a word if I've already one that
        # covers the current letter
        next if @found.grep( * ~~ / $_ / );

        # now search a new word
        @found.push: @words.grep( * ~~ / $_ / ).pick;
    }

    # all done
    @found.join( ' ' ).say;
}
