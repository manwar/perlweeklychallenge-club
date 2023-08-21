#!raku

#
# Perl Weekly Challenge 230
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-230/>
#

sub MAIN( Str $prefix where { $prefix.chars >= 2 },
	  *@words where { @words.elems == @words.grep( * ~~ Str ).elems } ) {
    my $count = 0;
    $count++ if ( $_ ~~ / ^ $prefix / ) for @words;
    $count.say;

}
