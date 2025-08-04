#!raku

#
# Perl Weekly Challenge 333
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-333>
#

sub MAIN( *@coordinates
	  where { @coordinates.grep( * ~~ Int ).elems == @coordinates.elems && @coordinates.elems %% 2  } ) {

    my @coords;
    for @coordinates -> $x, $y {
	@coords.push: { x => $x, y => $y };
    }

    my $first  = @coords[ 0 ];
    my $second = @coords[ 1 ];

    for 2 ..^ @coords.elems {
	my $current = @coords[ $_ ];
	'False'.say and exit if ( ( $current<x> - $first<x> ) * ( $first<y> - $second<y> )
				  != ( $current<y> - $first<y> ) * ( $first<x> - $second<x> ) );
    }

    'True'.say;
}
