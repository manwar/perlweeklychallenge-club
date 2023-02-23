#!raku

#
# Perl Weekly Challenge 205
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-205/>
#

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {

    my @highests = @list.unique.sort;
    @highests[ * - ( @highests.elems > 2 ?? 3 !! 1 ) ].say;
}
