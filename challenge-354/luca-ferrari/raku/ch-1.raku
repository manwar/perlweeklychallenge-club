#!raku

#
# Perl Weekly Challenge 354
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-354>
#

sub MAIN( *@nums is copy
	  where { @nums.elems %% 2 && @nums.grep( * ~~ Int ).elems == @nums.elems } ) {
    @nums .= sort;
    my %diffs;
    @nums[ 0 .. * - 2].map( { state $i = 0;
			      %diffs{ @nums[ $i + 1 ] - @nums[ $i ] }.push: [ @nums[ $i + 1 ], @nums[ $i ] ];
			      $i++;
			    } );

    %diffs{ %diffs.keys.map( *.Int ).min }.join( "\n" ).say;
}
