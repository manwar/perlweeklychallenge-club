#!raku

#
# Perl Weekly Challenge 300
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-300>
#

sub MAIN( *@ints where { @ints.elems == @ints.grep( * ~~ Int ) } ) {

    my @set;

    for 0 ..^ @ints.elems -> $current-set {
	my @current;

	@current[ 0 ] = @ints[ $current-set ];
	for 0 ..^ @ints.elems {
	    next if $_ == $current-set;

	    my $zero-element = @current[ 0 ];
	    my $current-element = @ints[ $zero-element ];
	    my $current-index = $_ - 1;

	    while ( $current-index > 0 ) {
		$current-element = @ints[ $current-element ];
		$current-index--;
	    }

	    last if @current.grep( * ~~ $current-element );
	    @current[ $_ ] = $current-element if ( $current-element );
	}

	@set.push: @current;
    }

    @set.map( *.elems ).max.say;

}
