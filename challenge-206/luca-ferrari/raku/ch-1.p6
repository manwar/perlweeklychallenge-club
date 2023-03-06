#!raku

#
# Perl Weekly Challenge 206
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-206/>
#

sub diff ( $start, $end ) {
    my ( $start-hours, $start-mins ) = $start.chomp.split( ':' );
    my ( $end-hours, $end-mins ) = $end.chomp.split( ':' );

    if ( $start-hours == 0 ) {
	$start-hours = 23;
	$start-mins += 60;
    }

    if ( $end-hours == 0 ) {
	$end-hours = 23;
	$end-mins += 60;
    }

    my $diff-hours = abs( $end-hours - $start-hours );
    my $diff-mins  = abs( $end-mins - $start-mins ) % 60;

    return $diff-hours * 60 + $diff-mins;

}

sub MAIN( :$verbose = True, *@times where { @times.grep( * ~~ / ^ \d ** 2 ':' \d ** 2 $ /  ).elems == @times.elems } ) {

    my %diffs;
    %diffs{ diff( $_[ 1 ], $_[ 0 ] ) } = [ $_[0], $_[1] ] for @times.sort.combinations( 2 );

    %diffs.keys.map( *.Int ).min.say;
    %diffs{ %diffs.keys.map( *.Int ).min }.join( ' - ' ).say if ( $verbose );
}
