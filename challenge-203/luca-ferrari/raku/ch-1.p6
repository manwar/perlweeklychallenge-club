#!raku

#
# Perl Weekly Challenge 203
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-203/>
#

sub MAIN( Bool :$verbose = True,  *@list where { @list.grep( * ~~ Int ).elems == @list.elems } )  {
    my @quadruplets;

    for 0 ..^ @list.elems -> $a {
	for $a ^..^ @list.elems -> $b {
	    for $b ^..^ @list.elems -> $c {
		for $c ^..^ @list.elems -> $d {
		    my ( $la, $lb, $lc, $ld ) = @list[ $a ], @list[ $b ], @list[ $c ], @list[ $d ];
		    @quadruplets.push: [ $la, $lb, $lc, $ld ] if ( ( $la + $lb + $lc ) == $ld );
		}
	    }
	}
    }

    @quadruplets.join( "\n -> " ).say if $verbose;
    @quadruplets.elems.say;
}
