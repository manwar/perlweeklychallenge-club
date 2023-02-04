#!raku

#
# Perl Weekly Challenge 202
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
#

sub MAIN( Bool :$verbose = False,
	*@list where { @list.grep( { $_ ~~ Int && $_ > 0 } ).elems == @list.elems } ) {
    my @odds;
    for @list {
	next if $_ %% 2;
	@odds.push: $_ and next if ( ! @odds );
	next if @odds.grep( $_ );
	next if $_ != ( @odds[ * - 1 ] + 2 );
	@odds.push: $_;
    }

    @odds.join( ', ' ).say if $verbose;
    '1'.say and exit if ( @odds.elems >= 3 );
    '0'.say;
}
