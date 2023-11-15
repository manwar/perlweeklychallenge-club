#!raku

#
# Perl Weekly Challenge 243
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
#

sub MAIN( Bool :$verbose = True,
			   *@nums where { @nums.elems == @nums.grep( { $_ ~~ Int } ).elems } ) {


    # A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].
    my @reverse_pairs;
    for 0 ..^ @nums.elems -> $i {
	@reverse_pairs.push: [ @nums[ $i ], $_ ] for  @nums[ $i + 1 .. * ].grep( { @nums[ $i ] > 2 * $_ } );
    }

    @reverse_pairs.elems.say;
    @reverse_pairs.join( "\n" ).say if $verbose;
}
