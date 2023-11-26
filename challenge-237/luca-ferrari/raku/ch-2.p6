#!raku

#
# Perl Weekly Challenge 237
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-237/>
#

sub MAIN( *@nums where { @nums.grep( * ~~Int ).elems == @nums.elems } ) {

    my %permutations;

    for @nums.permutations -> $current-permutation {
	for 0 ..^ @nums.elems {
	    if ( @nums[ $_ ] > $current-permutation[ $_ ] ) {
		%permutations.{ $_ }.push: $current-permutation;
		last;
	    }
	}
    }

    my $greatest = %permutations.keys.max;
    my $permutations = %permutations{ $greatest }.elems;
    "Greatest $greatest with $permutations possible permutations".say;
    %permutations{ $greatest }[ 0 ].join( ',' ).say;
}
