#!raku

#
# Perl Weekly Challenge 281
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-281>
#


sub compute-end-points( $start ) {
    my @end-points;
    my @valid-columns = 'a' .. 'h';

    $start ~~ / ^ $<column>=( <[a..h]> ) $<row>=( <[1..8]> ) $ /;
    my $row = $<row>.Int;
    my $column = $<column>.Str;

    return Nil if ( $row > 8 || $row < 1 || ! @valid-columns.grep( { $_ ~~ $column } ) );

    # at which index is the current column labeled with a letter?
    $column    = @valid-columns.grep( { $_ ~~ $column }, :k )[ 0 ];

    my @moves = [ +1, -2 ], [ +1, +2 ],
		[ +2, -1 ], [ +2, +1 ],
		[ -1, -2 ], [ -1, +2 ],
		[ -2, -1 ], [ -2, +1 ];

    @end-points = @moves.map(
	{  [ @valid-columns[ $_[ 0 ] + $column ], $_[ 1 ] + $row ] } )
		   .grep( { $_[ 0 ] && @valid-columns.grep( * ~~ $_[ 0 ] ) && 1 <= $_[ 1 ] <= 8 } )
		   .map( { $_[ 0 ] ~ $_[ 1 ] } );
		   ;
    return @end-points;
}


sub MAIN( Str $start,
	  Str $end,
	  :$verbose
			  where { $start !~~ $end
				  and $start ~~ / ^ <[a..h]> <[1..8]> $ /
				  and $end ~~ / ^ <[a..h]> <[1..8]> $ / }
			   ) {


    my @end-points = compute-end-points( $start );

    my @paths;
    @paths = @end-points.map( $start ~ '-' ~ * );

    my @new-paths;
    my $found = False;
    my $debug = 0;
    while ( ! $found ) {
	for @paths.sort -> $current-path  {
	    my $next = $current-path.split( '-' )[ * - 1 ];
	    my @ends = compute-end-points( $next ).grep( { $_ ne $start && $_ ne $next } );
	    @new-paths.push: $current-path ~ '-'  ~ $_ for @ends;
	}

	@paths = @new-paths;
	@new-paths = ();
	$found = @paths.grep( * ~~ / $end $ / );

    }



    my %possible-moves;
    for @paths.grep( * ~~ / $end $ / ) {
	%possible-moves{ $_.split( '-' ).elems }.push: $_;
    }

    my $min-moves = %possible-moves.keys.min;
    $min-moves.say;
    if ( $verbose ) {
	"possible moves:".say;
	%possible-moves{ $min-moves  }.sort.join( "\n" ).say;
    }
}
