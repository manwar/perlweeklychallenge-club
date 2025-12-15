#!raku

#
# Perl Weekly Challenge 352
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-352>
#

sub MAIN( *@bits where { @bits.grep( * ~~ / <[0|1]> / ).elems == @bits.elems } ) {
    my @binaries;
    for 0 ..^ @bits.elems {
	my $val = @bits[ 0 .. $_ ].join.parse-base( 2 ).Int;
	@binaries.push: @bits[ 0 .. $_ ].join if ( $val %% 5 );
    }

    @binaries.join( ', ' ).say;
}
