#!raku

#
# Perl Weekly Challenge 348
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-348>
#

sub MAIN( Str $source, Str $target where { $source ~~ / ^ \d ** 2 <[:]> \d ** 2 $ / && $target ~~ / ^ \d ** 2 <[:]> \d ** 2 $ / } ) {
    my %begin = hour => $source.split( ':' )[ 0 ],
		mins => $source.split( ':' )[ 1 ];

    my %end = hour => $target.split( ':' )[ 0 ],
	      mins => $target.split( ':' )[ 1 ];


    %begin<mins> = %begin<mins> + %begin<hour> * 60;
    %end<mins>   = %end<mins> + %end<hour> * 60;

    my @operations;

    for ( 60, 15, 10, 5, 1 ) -> $current {
	while ( %end<mins> - %begin<mins> >= $current ) {
	    %begin<mins> += $current;
	    @operations.push: $current;

	}
    }

    @operations.elems.say;

}
