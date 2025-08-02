#!raku

#
# Perl Weekly Challenge 308
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-308>
#

sub MAIN(  :@left,  :@right ) {

    my @matches;

    for @left -> $left {
	@matches.push: $left if ( @right.grep( * ~~ $left ) );
    }

    @matches.elems.say;
}
