#!raku

#
# Perl Weekly Challenge 200
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-200/>
#

sub MAIN( *@list where { @list.elems == @list.grep( * ~~ Int ).elems } ) {
    my @slices;

    for 0 ^..^ @list.elems - 1 -> $center {
	for 1 .. $center {
	    my ( $start, $end ) = $center - $_, $center + $_;
	    $start = 0 if $start < 0;
	    $end = @list.elems - 1 if $end >= @list.elems;

	    my @seeking = @list[ $start .. $end ];
	    my $ok = @list.elems >= 3;
	    for 1 ..^ @seeking.elems {
		state $difference = @seeking[ $_ ] - @seeking[ $_ - 1 ];
		$ok = False and last if @seeking[ $_ ] - @seeking[ $_ - 1 ] != $difference;
	    }

	    @slices.push: @seeking if $ok;
	}
    }

    @slices.join( "\n" ).say;



}
