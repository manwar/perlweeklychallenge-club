#!raku

# Perl Weekly Challenge 196

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {

    my @ranges;
    my $start = -1;
    my $end   = -1;
    for 0 .. @list.elems {
	next if ! $_;
	next if $_ <= $end;

	$start = $_;
	$end   = $start;

	$end++ while ( $end < @list.elems &&  @list[ $end + 1 ] == @list[ $end ] + 1 );
	@ranges.push: [ $start, $end ] if ( $start < $end );
    }

    @ranges.join( "\n" ).say;
}
