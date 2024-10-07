#!raku

#
# Perl Weekly Challenge 290
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-290>
#

sub MAIN( *@numbers where { @numbers.elems == @numbers.grep( * ~~ Int ).elems } ) {
    my @found;

    for 0 ..^ @numbers.elems -> $i {
	for $i ..^ @numbers.elems -> $j {
	    @found.push: [ $i, $j ] if ( @numbers[ $i ] == 2 * @numbers[ $j ] );
	}
    }

    'True'.say and exit if ( @found );
    'False'.say;
}
