#!raku

#
# Perl Weekly Challenge 202
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
#

sub MAIN( *@list where { @list.grep( { $_ > 0 && $_ ~~ Int } ).elems == @list.elems } ) {

    my %valleys;

    for 0 ..^ @list.elems - 1 {
	my $current = @list[ $_ ];
	next if @list[ $_ + 1 ] > $current;  # increasing!

	my @valley-left;
	for $_ ..^ @list.elems {
	    @valley-left.push: @list[ $_ ] if ( @list[ $_ ] <= $current );
	    last if @list[ $_ ] > $current;
	}

	my @valley-right;
	$current = @list[ $_ + @valley-left.elems ];
	if ( $_ + @valley-left.elems  < @list.elems ) {
	    for $_ + @valley-left.elems ..^ @list.elems {
		@valley-right.push: @list[ $_ ] if ( @list[ $_ ] >= $current );
		last if @list[ $_ ] < $current;
	    }
	}

	%valleys{ @valley-left.elems + @valley-right.elems } = [ |@valley-left, |@valley-right ];
    }

    %valleys{ %valleys.keys.max }.join( ', ' ).say;

}
