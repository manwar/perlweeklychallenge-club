#!raku

#
# Perl Weekly Challenge 215
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-215/>
#

sub MAIN( *@words where { @words.grep( * ~~ / ^ <[a..zA..Z]>+ $ / ).elems == @words.elems } ) {

    say ( @words.elems -  @words.grep( { $_ ~~ $_.comb.sort.join } ).elems );
}
