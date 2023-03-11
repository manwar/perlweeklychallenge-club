#!raku

#
# Perl Weekly Challenge 207
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-207/>
#


# The H-Index is the largest number h such that h articles have at least h citations each.
# For example, if an author has five publications, with 9, 7, 6, 2, and 1 citations
# (ordered from greatest to least),
# then the author’s h-index is 3, because the author has three publications
# with 3 or more citations.
# However, the author does not have four publications with 4 or more citations.

sub MAIN( *@citations where { @citations.grep( * ~~ Int ).elems == @citations.elems } ) {
    @citations.sort.reverse.pairs.first( { $_.key >= $_.value  } ).key.say;
}
