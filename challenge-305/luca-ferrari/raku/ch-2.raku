#!raku

#
# Perl Weekly Challenge 306
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-306>
#

sub MAIN( Str $dictionary, *@words ) {

    my @sorted;
    my @alien-dictionary = $dictionary.lc.comb( /<[a .. z]>/ );

    @sorted = @words.sort( { @alien-dictionary.grep( * ~~ $^a.lc.comb[0], :k ).first <=> @alien-dictionary.grep( * ~~ $^b.lc.comb[0], :k ).first } );
    @sorted.join( ', ' ).say;
}
