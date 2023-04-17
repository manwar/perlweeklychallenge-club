#!raku

#
# Perl Weekly Challenge 212
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-212/>
#

sub MAIN( *@args ) {
    my $size = @args[ * - 1 ];
    my @list = @args[ 0 .. * - 2 ];

    # check if the size can be used to split the list
    '-1'.say and exit if ( @list.elems !%% $size );

    my $bag = Bag.new( @list ).Hash;

    my @batches;
    my @current;
    while ( @batches.elems != ( @list.elems / $size ) ) {

	my @available-keys = $bag.keys.grep( { $bag{ $_ } > 0 && ! @current.grep( $_ ) } );
	my $key = @available-keys.min;
	@current.push: $key;

	$bag{ $key } -= 1;
	$bag{ $key }:delete  if ( $bag{ $key } <= 0 );

	if ( @current.elems == $size ) {
	    @batches.push: [ @current ];
	    @current = ();
	}
    }

    @batches.join( "\n" ).say;
}
