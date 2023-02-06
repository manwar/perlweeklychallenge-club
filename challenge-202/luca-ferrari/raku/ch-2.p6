#!raku

#
# Perl Weekly Challenge 202
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
#

sub MAIN( *@list where { @list.grep( { $_ > 0 && $_ ~~ Int } ).elems == @list.elems } ) {

    my %valleys;

    for 0 ..^ @list.elems - 1 -> $index {
	my $current = @list[ $index ];
	next if @list[ $index + 1 ] > $current;  # increasing!

	my @valley-left;
	@valley-left.push: $current;
	for $index ^..^ @list.elems {
	    my $previous = @valley-left[ * - 1 ];
	    @valley-left.push: @list[ $_ ] if ( @list[ $_ ] <= $previous );
	    last if @list[ $_ ] > $previous;
	}

	my @valley-right;

	if ( $index + @valley-left.elems  < @list.elems ) {
	    @valley-right.push: @list[ $index + @valley-left.elems ];
	    for $index + @valley-left.elems ^..^ @list.elems {
		my $previous = @valley-right[ * - 1 ];
		@valley-right.push: @list[ $_ ] if ( @list[ $_ ] >= $previous );
		last if @list[ $_ ] < $previous;
	    }
	}

	%valleys{ @valley-left.elems + @valley-right.elems } = [ |@valley-left, |@valley-right ];
    }

    %valleys{ %valleys.keys.max }.join( ', ' ).say;

}
