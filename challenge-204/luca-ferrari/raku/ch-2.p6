#!raku

#
# Perl Weekly Challenge 204
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-204/>
#

# raku raku/ch-2.p6 -r=3 -c=2 "1 2 3" "4 5 6"
# [[1 2] [3 4] [5 6]]

sub MAIN( Int :$r, Int :$c, *@matrix ) {
    my @M = @matrix.map: {  $_.split( ' ' )  };

    # if cannot reshape, exit
    '0'.say and exit if ( $r * $c ) < ( @M.elems * @M[ 0 ].elems );

    my @N;
    my @new-row;
    for @M -> $row {

	for 0 ..^ $row.elems {
	    @new-row.push: $row[ $_ ] if ( @new-row.elems < $c );
	    @N.push: [ @new-row ] if ( @new-row.elems == $c );
	    @new-row = () if ( @new-row.elems == $c );

	}
    }

    @N.join( "\n" ).say;
}
