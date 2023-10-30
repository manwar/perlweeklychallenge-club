#!raku

#
# Perl Weekly Challenge 236
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-236/>
#

sub MAIN( *@nums  where { @nums.grep( * ~~ Int ).elems == @nums.elems } ) {

    my @loops;
    for 0 ..^ @nums.elems -> $current-start {
	my @current-path = ();

	@current-path.push: @nums[ $current-start ];

	my $next = @nums[ $current-start ];
	while ( 0 < $next < @nums.elems ) {
	    @current-path.push: @nums[ $next ];

	    if @nums[ $next ] == $current-start {
		# loop detected
		@loops.push: @current-path;
		last;
	    }

	    $next = @nums[ $next ];
	}

    }

    @loops.elems.say;
}
