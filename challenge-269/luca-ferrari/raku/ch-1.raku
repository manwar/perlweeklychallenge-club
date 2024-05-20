#!raku

#
# Perl Weekly Challenge 269
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-269>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( { $_ ~~ Int && $_ > 0 } ).elems } ) {
    my @couples;
    for 0 ..^ @nums.elems -> $i {
	for $i ^..^ @nums.elems -> $j {
	    @couples.push: [ @nums[ $i ], @nums[ $j ] ] if ( ( @nums[ $i ] +| @nums[ $j ] ) %% 2 );
	}
    }

    @couples.join( "\n" ).say;
}
