#!raku

#
# Perl Weekly Challenge 204
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-204/>
#

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my $monotonic-type;
    for 0 ^..^ @list.elems {
	if ( ! $monotonic-type ) {
	    $monotonic-type = ( @list[ $_ ] > @list[ $_ - 1 ] ) ?? True !! False;
	}

	# elements are the same
	next if @list[ $_ ] == @list[ $_ - 1 ];

	'0'.say and exit if ( ! $monotonic-type && @list[ $_ ] > @list[ $_ - 1 ] );
	'0'.say and exit if (   $monotonic-type && @list[ $_ ] < @list[ $_ - 1 ] );
    }

    '1'.say;
}
