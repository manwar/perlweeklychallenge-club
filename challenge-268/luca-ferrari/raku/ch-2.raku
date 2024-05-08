#!raku

#
# Perl Weekly Challenge 268
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-268>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems  && @nums.elems %% 2 }  ) {
    my @sorted;
    for @nums.sort.rotor( 2 ) -> @couple {
	@sorted.push: @couple.reverse.flat;
    }

    @sorted.join( " " ).say;
}
