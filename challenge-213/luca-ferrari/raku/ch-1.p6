#!raku

#
# Perl Weekly Challenge 213
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-213/>
#

sub MAIN( *@n where { @n.elems == @n.grep( { $_ ~~ Int && $_ > 0 } ).elems } ) {
    ( @n.grep( * %% 2 ).sort.join( ',' ) ~ ',' ~ @n.grep( * !%% 2 ).sort.join( ',' ) ).say;
}
